---
name: review
description: Review the current git working diff (staged + unstaged) with the read-only reviewer subagent. Use after edits, before committing, or on /review.
---

# Review the working diff

1. `git status --short` and `git diff -U3 HEAD` to collect the diff. Not a git repo or empty diff → say so and stop.
2. `invoke_subagent` with TypeName `reviewer` (fall back to `research` if `reviewer` is not listed), passing the full diff verbatim plus this instruction: "Review these changes for correctness bugs, security issues, and violations of any AGENTS.md/GEMINI.md conventions in this repo."
3. Report the reviewer's findings verbatim (it already formats severity/file/line/fix).
4. Findings exist → end with `Fix first, then re-run /review.` None → `No blocking findings. Ready to commit.`

Do not apply fixes in this skill — review only.
