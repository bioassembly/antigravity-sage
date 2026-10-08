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

# 4. MCP Config
MCP_CONF="$HOME/.gemini/config/mcp_config.json"
if [ -f "$MCP_CONF" ]; then
  if python3 -m json.tool "$MCP_CONF" &>/dev/null; then
    check_pass "mcp_config.json is valid JSON ($(jq -r '.mcpServers | keys | join(", ")' "$MCP_CONF" 2>/dev/null))"
  else
    check_fail "mcp_config.json has invalid JSON syntax"
  fi
else
  check_fail "mcp_config.json not found at $MCP_CONF"
fi

# 5. Remote endpoints test
if curl -s -X POST https://mcp.context7.com/mcp --max-time 4 -H "Content-Type: application/json" -d '{}' &>/dev/null; then
  check_pass "Context7 remote MCP endpoint responsive"
else
  check_warn "Context7 remote MCP endpoint unreachable or slow"
fi

if curl -s -X POST https://mcp.deepwiki.com/mcp --max-time 4 -H "Content-Type: application/json" -d '{}' &>/dev/null; then
  check_pass "DeepWiki remote MCP endpoint responsive"
else
  check_warn "DeepWiki remote MCP endpoint unreachable or slow"
fi

# 6. Global Rules
RULES_FILE="$HOME/.gemini/config/AGENTS.md"
if [ -f "$RULES_FILE" ]; then
  check_pass "Global AGENTS.md rules active ($(wc -l < "$RULES_FILE") lines)"
else
  check_warn "Global AGENTS.md rules not found at $RULES_FILE"
fi

# 7. Skills count
SKILLS_DIR="$HOME/.gemini/config/skills"
if [ -d "$SKILLS_DIR" ]; then
  COUNT=$(find -L "$SKILLS_DIR" -mindepth 1 -maxdepth 1 -type l -o -type d | wc -l)
  check_pass "Active skills installed: $COUNT skills available"
else
  check_fail "Skills directory not found at $SKILLS_DIR"
fi

# 8. Custom Subagents
AGENTS_DIR="$HOME/.gemini/config/agents"
if [ -d "$AGENTS_DIR" ]; then
  AGENTS_LIST=$(find -L "$AGENTS_DIR" -maxdepth 2 -name "agent.md" | sed 's|.*/agents/||; s|/agent.md||' | tr '\n' ' ')
  check_pass "Custom subagents registered: $AGENTS_LIST"
else
  check_warn "Agents directory not found at $AGENTS_DIR"
fi

# 9. Settings
SETTINGS_FILE="$HOME/.gemini/antigravity-cli/settings.json"
if [ -f "$SETTINGS_FILE" ]; then
  check_pass "settings.json active (autonomy: $(jq -r '.toolPermission // "default"' "$SETTINGS_FILE" 2>/dev/null))"
else
  check_warn "settings.json not found at $SETTINGS_FILE"
fi

echo "==============================================="
