---
name: checkpoint
description: Dump current task state to NOTES.md in the working directory so work survives context compaction or a session restart. Use on /checkpoint or before ending a long session.
---

# Checkpoint task state

1. Read `NOTES.md` in the working directory if it exists — merge, never clobber unrelated content.
2. Write/update these sections:

```
# NOTES — <one-line task name>
## Goal
## Done            # with file:line refs
## In progress     # exact step it stopped at
## Next steps      # ordered, actionable
## Decisions       # choice + why (one line each)
## Resume hint     # what to read first to pick this up cold
```

Rules:
- Max ~60 lines. Paths and identifiers verbatim — a fresh session must resume without re-exploring.
- Also push durable facts/decisions to the `memory` MCP (`create_entities` / `add_observations`) if it is connected. Never secrets.
- No task in progress → say so and stop; do not create an empty NOTES.md.
- Confirm the path written.
