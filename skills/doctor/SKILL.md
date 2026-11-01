---
name: doctor
description: Run health diagnostics on the Antigravity harness (MCP endpoints, Serena LSP, skills count, custom subagents, rules, permissions). Use on /doctor.
---

# Harness Health Check (Doctor)

Execute the health check suite to verify harness integrity:

1. Run the diagnostic script (resolving the installed repository dynamically from the skill symlink):
   `SKILL_REAL="$(readlink -f ~/.gemini/config/skills/doctor)" && bash "$(cd "$(dirname "$SKILL_REAL")/../.." && pwd)/scripts/doctor.sh"`
2. Inspect the output and report:
   - Any failing or warning components with remediation steps.
   - Active MCP servers and responsiveness.
   - Installed subagents and skills tally.
