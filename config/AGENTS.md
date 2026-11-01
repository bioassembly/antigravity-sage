# Antigravity Agent Protocol

## Skill & Tool Protocol

Before starting any non-trivial task:
1. Check available skills (`/skills`); activate the skill matching the task and follow its runbook.
2. For code navigation, symbol lookups, cross-file references, or refactorings in projects: use Serena MCP tools (`find_symbol`, `get_symbols_overview`, `find_referencing_symbols`) before reading raw files.
3. No matching skill → note `[SKILL GAP: <topic>]`, and use the `skill-acquisition` skill to fetch, vet (stars, maintenance, security), and install the skill into `~/.gemini/config/skills/`.
4. **Autonomous Binary & Opaque Artifact Exploration**: While exploring a codebase or directory, keep Serena LSP for readable source files, and **automatically** activate `reverse-engineer-anything` (`rea` CLI: `rea inspect-artifact`, `rea analyze-javascript-application`, `rea inspect-binary-layout`, etc.) whenever you encounter compiled binaries, `.so`/`.dll`/`.dylib` libraries, `.apk`/`.asar` packages, `.wasm`/`.pyc`/`.jar` bytecode, firmware, or minified JS bundles without source — never wait for the user to ask for `rea`.

## Token Budget & Optional Local Offloading Rules

- **Strict File Slicing**: On files >150 lines, always use `read_file` with `StartLine`/`EndLine` ranges (max 150 lines per slice) or targeted `grep`. Never dump entire files into context. Never re-read files already present in context.
- **Optional Local Offloading (`hybrid-sage`)**: When the `hybrid-sage` MCP server is connected, call `fleet_status` before mechanical tasks (test scaffolding, mock data, boilerplate, schema translation, cross-family diff review). If an OpenCode worker is online and idle (`slot_0_busy: false`), use `delegate_local` (`skip_if_busy: true`) so full outputs write directly to disk and only clean summaries (`<=3000` chars) return to cloud. If offline or cloud-only, execute directly without blocking.
- **Airgap & Privacy Firewall**: When `hybrid-sage` is connected, run `airgap_scan` before sending unfamiliar logs, configs, or clinical/genomic files to cloud models.

## Self-Improvement & Continuous Learning

1. **Vetting ladder**: Official docs (`docs.<tool>.io/llms.txt`) -> official repos -> curated collections (`obra/superpowers`, `K-Dense-AI/scientific-agent-skills`, `anthropics/skills`) -> web search.
2. **Quality bar**: ≥1,000 stars (≥100 for niche bioinformatics); pushed within 12 months; zero malicious patterns; concise YAML frontmatter with actionable description.
3. **Register**: Record provenance in `REGISTRY.md` and link the skill into `~/.gemini/config/skills/`.

## Multi-Agent & Subagent Guidelines

- For pre-implementation red-teaming: invoke the `skeptic` subagent (attacks hidden assumptions, failure modes, simpler alternatives).
- For pre-commit code review: invoke the `reviewer` subagent (read-only audit for correctness, security, conventions).
- For bioinformatics, Nextflow DSL2 pipelines, Quarto reports, and HPC jobs: use the `bioinformatician` agent persona or skill.
- For deep algorithmic debugging or complex race conditions: recommend `/boost`.

## Hard Rules

- **Tight responses**: Direct, concise, technical. No fluff, no unsolicited preamble or postamble.
- **Minimal diffs**: No drive-by reformatting, no unsolicited renames. Suggest cosmetic cleanups separately.
- **Verify before claiming done**: Run the narrowest test or command that can fail and cite executed evidence. No evidence, no "done".
- **Genomics & Python stack**: Prioritize `conda install -c bioconda -c conda-forge` for compiled bioinformatics tools; Python packages outside conda use `--break-system-packages`. Nextflow pipelines follow nf-core conventions with stub tests (`-stub-run`) before real data.
- **Durable memory**: Persist important architectural decisions, conventions, and user preferences to the `memory` MCP server. Never store credentials or API keys.
