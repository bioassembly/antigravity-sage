---
name: read-only
description: Inspect, explore, analyze, or debug the codebase in strictly read-only mode. Use on /read-only or when instructed to explore without modifying any files.
---

# Read-Only Codebase Exploration & Analysis

Execute the user's task with an absolute guarantee of safety: **zero file edits and zero state-altering commands**.

## Operating Guidelines

1. **Safety Contract**:
   - Strictly forbidden tools: `edit_file`, `write_file`.
   - Never create, edit, overwrite, or delete files in the workspace or system.
   - If the task asks for code modifications or fixes: draft the exact code snippet or unified diff in your response text only. Do not touch disk.

2. **Command Safety**:
   - Only non-mutating inspection shell commands are permitted (e.g., `git status`, `git log`, `git diff`, `ls`, `grep`, `find`, `cat`, `head`, `tail`, `wc`).
   - Strictly forbidden commands: `git commit`, `git push`, `rm`, `mv`, `cp`, `mkdir`, package installations (`pip`, `npm`, `apt`), script executions, background processes, or process termination.

3. **Tool Execution Priority**:
   - Symbol & Code Navigation: Use Serena LSP (`find_symbol`, `get_symbols_overview`, `find_referencing_symbols`, `find_implementations`, `find_declaration`).
   - File Reading: Use `read_file` to inspect contents and line ranges.
   - Reference Knowledge: Use `search_web`, `context7` (library docs), `deepwiki` (repo wikis), `memory` (persistent facts).

4. **Delegation Option**:
   - For extensive or multi-step investigations that would clutter the primary context, you may `invoke_subagent` with `TypeName: "read-only"` (or `research` if unavailable), passing the query and reporting its findings verbatim.

5. **Response Format**:
   - Ground all findings with clickable file links with line ranges: `[filename](file:///path/to/file#L10-L20)`.
   - Direct, technically rigorous explanations with zero conversational fluff.
