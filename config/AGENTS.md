# Antigravity Agent Protocol

## Skill & Tool Protocol

Before starting any non-trivial task:
1. Check available skills (`/skills`); activate the skill matching the task and follow its runbook.
2. For code navigation, symbol lookups, cross-file references, or refactorings in projects: use Serena MCP tools (`find_symbol`, `get_symbols_overview`, `find_referencing_symbols`) before reading raw files.
3. No matching skill → note `[SKILL GAP: <topic>]`, and use the `skill-acquisition` skill to fetch, vet (stars, maintenance, security), and install the skill into `~/.gemini/config/skills/`.

## Self-Improvement & Continuous Learning

1. **Vetting ladder**: Official docs (`docs.<tool>.io/llms.txt`) -> official repos -> curated collections (`obra/superpowers`, `K-Dense-AI/scientific-agent-skills`, `anthropics/skills`) -> web search.
2. **Quality bar**: ≥1,000 stars (≥100 for niche bioinformatics); pushed within 12 months; zero malicious patterns; concise YAML frontmatter with actionable description.
3. **Register**: Add the skill to `~/antigravity-sage/REGISTRY.md` and link it to `~/.gemini/config/skills/`.

## Multi-Agent & Subagent Guidelines

- For pre-implementation red-teaming: invoke the `skeptic` subagent (attacks hidden assumptions, failure modes, simpler alternatives).
- For pre-commit code review: invoke the `reviewer` subagent (read-only audit for correctness, security, conventions).
- For bioinformatics, Nextflow DSL2 pipelines, Quarto reports, and HPC jobs: use the `bioinformatician` agent persona or skill.
- For deep algorithmic debugging or complex race conditions: recommend `/boost`.

## Hard Rules

- **Tight responses**: Direct, concise, technical. No fluff, no unsolicited preamble or postamble.
- **Minimal diffs**: No drive-by reformatting, no unsolicited renames. Suggest cosmetic cleanups separately.
- **Verify before claiming done**: Run the narrowest test or command that can fail and cite executed evidence. No evidence, no "done".
- **Genomics & Python stack**: Python packages outside conda use `--break-system-packages`. Nextflow pipelines follow nf-core conventions with stub tests (`-stub-run`) before real data.
- **Durable memory**: Persist important architectural decisions, conventions, and user preferences to the `memory` MCP server. Never store credentials or API keys.
