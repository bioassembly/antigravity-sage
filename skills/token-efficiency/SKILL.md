---
name: token-efficiency
description: Context-window and token budget discipline for long sessions, large codebases, RAG-style retrieval questions, or when responses degrade late in a session.
---

# Token Efficiency Discipline

The context window is the scarcest resource. Every token spent on noise is one not spent on your code.

## Retrieval ladder — cheapest first, escalate only on miss

1. **Serena LSP / symbol navigation**: Use `find_symbol`, `get_symbols_overview`, and `find_referencing_symbols` before reading raw files.
2. **Targeted grep/glob**: Search with tight regex patterns before reading any file. Never read a file just to "see what's there".
3. **Read slices**: Use `StartLine` and `EndLine` around the target symbol, not whole files. Multi-thousand line reads waste context budget.
4. **context7 MCP / DeepWiki MCP**: Query library APIs and GitHub docs directly instead of reading vendored dependencies or guessing.
5. **Full-file read**: Only after 1-4 fail, or for small configuration files (<100 lines).

Example shapes:
- Bad: read `src/auth/service.ts` (1,800 lines) to find where tokens refresh.
- Good: `find_symbol` on `refreshToken` or grep for `refreshToken` -> hit at line 412 -> read lines 395-435 (~40 lines vs 1,800 lines).

## Output hygiene

- Scoped command execution: If a command produces substantial output, pipe through `head`, `grep`, or `wc -l` first.
- Offload deep exploratory tasks: Delegate large codebase surveys, broad documentation scans, and experimental investigations to subagents (`research` or `self`) so raw exploratory transcripts stay out of the primary context.

## Session shape

- One logical task per session; suggest `/compact` between tasks when context grows.
- Durable notes: Any task outliving ~30 minutes or one compaction cycle should checkpoint state to `NOTES.md` and durable memory.
- Avoid large pastes into context: Reference files by path rather than re-pasting large blocks.
- Concise summaries: State decisions tersely ("using X because Y") rather than re-pasting prior rationale.

## RAG honesty

For a local repository, exact symbol lookups (Serena) and grep-first retrieval consistently beat vector embeddings in precision. Reach for semantic retrieval (`context7` or `deepwiki`) only when exploring external documentation or third-party packages where the vocabulary is not yet known.
