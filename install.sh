#!/usr/bin/env bash
set -eo pipefail

RECIPE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GEMINI_CONFIG="$HOME/.gemini/config"
CLI_DIR="$HOME/.gemini/antigravity-cli"

WITH_REA=false
for arg in "$@"; do
  case "$arg" in
    --with-rea) WITH_REA=true ;;
  esac
done

echo "=========================================================="
echo "  Deploying Antigravity Best-Practices State-of-the-Art Harness"
echo "=========================================================="

# Ensure base directories exist
mkdir -p "$GEMINI_CONFIG/skills"
mkdir -p "$GEMINI_CONFIG/agents"
mkdir -p "$CLI_DIR"
mkdir -p "$HOME/.config/opencode"

# 1. Install / Merge MCP Configuration (preserving existing & hybrid-sage)
echo "[-] Merging curated MCP server configuration..."
if [ -f "$GEMINI_CONFIG/mcp_config.json" ]; then
  cp "$GEMINI_CONFIG/mcp_config.json" "$GEMINI_CONFIG/mcp_config.json.bak.$(date +%s)"
fi

python3 - "$GEMINI_CONFIG/mcp_config.json" "$RECIPE_DIR/config/mcp_config.json" "$WITH_REA" "$HOME" <<'PY'
import json, os, sys

target_path, template_path, with_rea_str, home_dir = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
with_rea = with_rea_str.lower() in ("true", "1", "yes")

with open(template_path, "r", encoding="utf-8") as f:
    template_raw = f.read().replace("${HOME}", home_dir)
template = json.loads(template_raw)

target = {"mcpServers": {}}
if os.path.exists(target_path):
    try:
        with open(target_path, "r", encoding="utf-8") as f:
            target = json.load(f)
    except Exception:
        target = {"mcpServers": {}}

servers = target.setdefault("mcpServers", {})

# Merge base template servers (preserving non-overlapping keys)
for name, srv in template.get("mcpServers", {}).items():
    servers[name] = srv

# Handle REA (Reverse Engineer Anything) - 170 tools (~876 lazy name tokens/turn in Antigravity, ~67.6k schema tokens/turn if eager)
if with_rea:
    servers["rea"] = {
        "command": "npx",
        "args": ["-y", "rea-agents@6.4.0", "mcp"],
        "env": {"REA_MCP_INPUT_SCHEMA_PROFILE": "compact"}
    }
    print("✔ REA MCP included (--with-rea active).")
else:
    if "rea" in servers:
        del servers["rea"]
        print("✔ REA MCP omitted (170 tools; zero-overhead `rea` CLI active instead). Use --with-rea to enable MCP.")

with open(target_path, "w", encoding="utf-8") as f:
    json.dump(target, f, indent=2)
    f.write("\n")
print(f"✔ Curated MCP configuration merged into {target_path}")
PY

# 1b. Check if hybrid-sage plugin installer exists and run it
HYBRID_SAGE_DIR="${HYBRID_SAGE_DIR:-$(cd "$RECIPE_DIR/../hybrid-sage" 2>/dev/null && pwd || true)}"
HYBRID_SAGE_INSTALLER="${HYBRID_SAGE_DIR:+$HYBRID_SAGE_DIR/install-plugin.sh}"
if [ -n "$HYBRID_SAGE_INSTALLER" ] && [ -f "$HYBRID_SAGE_INSTALLER" ]; then
  echo "[-] Synchronizing Hybrid SAGE Open-Core Plugin & MCP schemas..."
  bash "$HYBRID_SAGE_INSTALLER"
fi

# 2. Install / Link Skills (public + optional gitignored skills.local/, pruning dead links)
echo "[-] Linking vetted skills into $GEMINI_CONFIG/skills/..."
for existing in "$GEMINI_CONFIG/skills"/*; do
  [ -L "$existing" ] && [ ! -e "$existing" ] && rm -f "$existing"
done
for skill_dir in "$RECIPE_DIR"/skills/*/; do
  [ -d "$skill_dir" ] || continue
  skill_name=$(basename "$skill_dir")
  ln -sfn "$skill_dir" "$GEMINI_CONFIG/skills/$skill_name"
done
if [ -d "$RECIPE_DIR/skills.local" ]; then
  for local_skill in "$RECIPE_DIR"/skills.local/*; do
    [ -e "$local_skill" ] || continue
    skill_name=$(basename "$local_skill")
    ln -sfn "$(readlink -f "$local_skill")" "$GEMINI_CONFIG/skills/$skill_name"
  done
fi

# 2b. Ensure zero-overhead `rea` CLI binary is available when npm is present
if ! command -v rea &>/dev/null && ! [ -x "$HOME/.local/bin/rea" ] && command -v npm &>/dev/null; then
  echo "[-] Installing rea-agents@6.4.0 CLI for autonomous binary inspection..."
  npm install -g --silent rea-agents@6.4.0 || true
fi

# 3. Install / Link Custom Subagents
echo "[-] Linking custom subagents into $GEMINI_CONFIG/agents/..."
for agent_dir in "$RECIPE_DIR"/agents/*/; do
  agent_name=$(basename "$agent_dir")
  ln -sfn "$agent_dir" "$GEMINI_CONFIG/agents/$agent_name"
done

# 4. Install Global Rules
echo "[-] Installing global AGENTS.md rules..."
cp "$RECIPE_DIR/config/AGENTS.md" "$GEMINI_CONFIG/AGENTS.md"

# 5. Configure settings.json permissions
echo "[-] Configuring permissions & settings in $CLI_DIR/settings.json..."
python3 - <<PY
import json, os

settings_path = os.path.expanduser("$CLI_DIR/settings.json")
template_path = os.path.expanduser("$RECIPE_DIR/config/settings.json")

with open(template_path) as f:
    template = json.load(f)

current = {}
if os.path.exists(settings_path):
    try:
        with open(settings_path) as f:
            current = json.load(f)
    except Exception:
        current = {}

# Merge permissions
current.setdefault("permissions", {})
current["permissions"]["deny"] = template["permissions"]["deny"]

# Merge allowed commands uniquely
allow_set = set(current["permissions"].get("allow", []))
for cmd in template["permissions"]["allow"]:
    allow_set.add(cmd)
current["permissions"]["allow"] = sorted(list(allow_set))

# Autonomous settings
current["toolPermission"] = template["toolPermission"]
current["artifactReviewPolicy"] = template["artifactReviewPolicy"]
current["allowNonWorkspaceAccess"] = template["allowNonWorkspaceAccess"]
current["notifications"] = template["notifications"]
current["trustedWorkspaces"] = [os.path.expanduser(p) for p in template.get("trustedWorkspaces", ["~"])]

with open(settings_path, "w") as f:
    json.dump(current, f, indent=2)
print("Updated settings.json with deny safeguards and allowed tools.")
PY

# 6. Run Doctor
echo ""
bash "$RECIPE_DIR/scripts/doctor.sh"

echo ""
echo "Deployment complete! Restart or run 'agy' to use the updated harness."
