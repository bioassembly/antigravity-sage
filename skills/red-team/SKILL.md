---
name: red-team
description: Red-team the current plan with the read-only skeptic subagent before any code is written. Use after planning, before implementation, or on /red-team.
---

# Red-team the plan

1. No plan stated in this conversation (and no implementation_plan artifact) → ask for it in one sentence and stop.
2. `invoke_subagent` with TypeName `skeptic` (fall back to `research`), passing the plan verbatim, the repo context it touches (paths, constraints), and: "Attack this plan: failure modes, hidden assumptions, simpler alternatives. Maximum 5 attacks, each with the cheapest check that would refute it."
3. Report the findings verbatim.
4. Close with `Revise the plan, then re-run /red-team.` or `Plan holds. Proceed to build.`

Attack only — do not start implementing.
