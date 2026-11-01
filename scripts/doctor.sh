#!/usr/bin/env bash
set -uo pipefail

echo "=== Antigravity Harness Health Check (Doctor) ==="

check_pass() { echo -e "[\033[32mPASS\033[0m] $1"; }
check_warn() { echo -e "[\033[33mWARN\033[0m] $1"; }
check_fail() { echo -e "[\033[31mFAIL\033[0m] $1"; }

# 1. agy CLI
if command -v agy &>/dev/null; then
  check_pass "agy CLI binary found at $(which agy)"
else
  check_fail "agy CLI binary not found in PATH"
fi

# 2. uv / uvx
if command -v uvx &>/dev/null; then
  check_pass "uvx binary found ($(uvx --version 2>&1 | head -1))"
else
  check_fail "uvx not found (required for Serena LSP MCP server)"
fi

# 3. node / npx
if command -v npx &>/dev/null; then
  check_pass "npx binary found ($(node --version 2>&1))"
else
  check_warn "npx not found (required for memory MCP server)"
fi

# 4. MCP Config & Hybrid SAGE Registration
MCP_CONF="$HOME/.gemini/config/mcp_config.json"
if [ -f "$MCP_CONF" ]; then
  if python3 -m json.tool "$MCP_CONF" &>/dev/null; then
    check_pass "mcp_config.json is valid JSON ($(jq -r '.mcpServers | keys | join(", ")' "$MCP_CONF" 2>/dev/null))"
    
    # Check hybrid-sage MCP specifically
    if jq -e '.mcpServers["hybrid-sage"]' "$MCP_CONF" &>/dev/null; then
      HS_SCRIPT=$(jq -r '.mcpServers["hybrid-sage"].args[0] // empty' "$MCP_CONF" 2>/dev/null || true)
      if [ -f "$HS_SCRIPT" ]; then
        check_pass "hybrid-sage MCP registered and script exists ($HS_SCRIPT)"
      else
        check_warn "hybrid-sage MCP registered but script not found at $HS_SCRIPT"
      fi
    else
      check_warn "hybrid-sage MCP not found in $MCP_CONF (run ./install.sh to merge)"
    fi
  else
    check_fail "mcp_config.json has invalid JSON syntax"
  fi
else
  check_fail "mcp_config.json not found at $MCP_CONF"
fi

# 5. Remote MCP Endpoints
if curl -s -f -X POST https://mcp.context7.com/mcp --max-time 3 -H "Content-Type: application/json" -H "Accept: application/json, text/event-stream" -d '{"jsonrpc":"2.0","method":"ping","id":1}' &>/dev/null; then
  check_pass "Context7 remote MCP endpoint responsive"
else
  check_warn "Context7 remote MCP endpoint unreachable or slow"
fi

if curl -s -f -X POST https://mcp.deepwiki.com/mcp --max-time 3 -H "Content-Type: application/json" -H "Accept: application/json, text/event-stream" -d '{"jsonrpc":"2.0","method":"ping","id":1}' &>/dev/null; then
  check_pass "DeepWiki remote MCP endpoint responsive"
else
  check_warn "DeepWiki remote MCP endpoint unreachable or slow"
fi

# 6. Tier-3 Local OpenCode Harness & Slot Telemetry
REPO_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROBE_SCRIPT="$REPO_ROOT_DIR/skills/hybrid-routing/scripts/probe_worker.sh"
PROBE_JSON=$(bash "$PROBE_SCRIPT" 2>/dev/null || echo '{"available":false}')
PROBE_AVAIL=$(echo "$PROBE_JSON" | jq -r '.available // false' 2>/dev/null || echo "false")
if [ "$PROBE_AVAIL" = "true" ]; then
  MODEL_NAME=$(echo "$PROBE_JSON" | jq -r '.model // "opencode-default"' 2>/dev/null || echo "opencode-default")
  SLOT_BUSY=$(echo "$PROBE_JSON" | jq -r '.slot_0_busy // false' 2>/dev/null || echo "false")
  if [ "$SLOT_BUSY" = "true" ]; then
    check_warn "Local OpenCode worker online ($MODEL_NAME), but slot 0 is BUSY (processing session)"
  else
    check_pass "Local OpenCode worker online & IDLE ($MODEL_NAME, slot 0 ready for delegate_local)"
  fi
else
  check_warn "Local OpenCode worker offline (Tier-3 auto-cascades to Tier 2 Flash)"
fi

# 7. Global Rules (AGENTS.md)
RULES_FILE="$HOME/.gemini/config/AGENTS.md"
if [ -f "$RULES_FILE" ]; then
  RULES_LINES=$(wc -l < "$RULES_FILE")
  if [ "$RULES_LINES" -le 60 ]; then
    check_pass "Global AGENTS.md rules active ($RULES_LINES lines, compact prompt footprint)"
  else
    check_warn "Global AGENTS.md rules active ($RULES_LINES lines — consider pruning to save per-turn tokens)"
  fi
else
  check_warn "Global AGENTS.md rules not found at $RULES_FILE"
fi

# 8. Skills count
SKILLS_DIR="$HOME/.gemini/config/skills"
if [ -d "$SKILLS_DIR" ]; then
  COUNT=$(find -L "$SKILLS_DIR" -mindepth 1 -maxdepth 1 -type l -o -type d | wc -l)
  check_pass "Active skills installed: $COUNT skills available"
else
  check_fail "Skills directory not found at $SKILLS_DIR"
fi

# 9. Custom Subagents
AGENTS_DIR="$HOME/.gemini/config/agents"
if [ -d "$AGENTS_DIR" ]; then
  AGENTS_LIST=$(find -L "$AGENTS_DIR" -maxdepth 2 -name "agent.md" | sed 's|.*/agents/||; s|/agent.md||' | tr '\n' ' ')
  check_pass "Custom subagents registered: $AGENTS_LIST"
else
  check_warn "Agents directory not found at $AGENTS_DIR"
fi

# 10. Settings & Autonomy
SETTINGS_FILE="$HOME/.gemini/antigravity-cli/settings.json"
if [ -f "$SETTINGS_FILE" ]; then
  check_pass "settings.json active (autonomy: $(jq -r '.toolPermission // "default"' "$SETTINGS_FILE" 2>/dev/null))"
else
  check_warn "settings.json not found at $SETTINGS_FILE"
fi

# 11. Token Overhead & Prompt Health Check
if [ -f "$MCP_CONF" ]; then
  if jq -e '.mcpServers["rea"]' "$MCP_CONF" &>/dev/null; then
    check_warn "REA MCP active (injects 140 tools / ~1,100 tokens per turn into system prompt; run ./install.sh without --with-rea if reverse engineering is not needed)"
  else
    check_pass "Lean MCP footprint active (~35 core tools, REA omitted, saving ~1,100 tokens/turn)"
  fi
fi

echo "==============================================="
