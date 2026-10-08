#!/usr/bin/env bash
set -eo pipefail

RECIPE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GEMINI_CONFIG="$HOME/.gemini/config"
CLI_DIR="$HOME/.gemini/antigravity-cli"

echo "=========================================================="
echo "  Deploying Antigravity Best-Practices State-of-the-Art Harness"
echo "=========================================================="

# Ensure base directories exist
mkdir -p "$GEMINI_CONFIG/skills"
mkdir -p "$GEMINI_CONFIG/agents"
mkdir -p "$CLI_DIR"

# 1. Install / Update MCP Configuration
echo "[-] Installing curated MCP server configuration..."
if [ -f "$GEMINI_CONFIG/mcp_config.json" ]; then
  cp "$GEMINI_CONFIG/mcp_config.json" "$GEMINI_CONFIG/mcp_config.json.bak.$(date +%s)"
fi
sed "s|\${HOME}|$HOME|g" "$RECIPE_DIR/config/mcp_config.json" > "$GEMINI_CONFIG/mcp_config.json"

# 2. Install / Link Skills
echo "[-] Linking vetted skills into $GEMINI_CONFIG/skills/..."
for skill_dir in "$RECIPE_DIR"/skills/*/; do
  skill_name=$(basename "$skill_dir")
  ln -sfn "$skill_dir" "$GEMINI_CONFIG/skills/$skill_name"
done

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
