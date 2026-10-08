---
name: doctor
description: Run health diagnostics on the Antigravity harness (MCP endpoints, Serena LSP, skills count, custom subagents, rules, permissions). Use on /doctor.
---

# Harness Health Check (Doctor)

Execute the health check suite to verify harness integrity:

1. Run the diagnostic script:
   `bash ~/Antigravity-best-practices/scripts/doctor.sh`
2. Inspect the output table and report:
   - Any failing components with remediation suggestions.
   - Active MCP servers and responsiveness.
   - Installed subagents and skills tally.
