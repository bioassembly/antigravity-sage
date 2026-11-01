# Antigravity Skills & MCP Registry

A curated, hardware-portable registry of state-of-the-art skills, custom subagents, and MCP servers tailored for bioinformatics, genomics pipelines, scientific software engineering, and full-stack software engineering.

## 1. Model Context Protocol (MCP) Servers

| Server Name | Transport | Purpose | Credentials / Env | Provenance & Quality |
|---|---|---|---|---|
| **`serena`** | stdio (`uvx serena-agent start-mcp-server --context antigravity --project-from-cwd --open-web-dashboard false`) | LSP-level code intelligence (find symbols, jump to references/definitions, symbol outline, semantic edits) across 40+ languages | None | `oraios/serena` (30.1k ⭐, MIT/GPL-3.0) |
| **`context7`** | Streamable HTTP (`https://mcp.context7.com/mcp`) | Up-to-date documentation and library API references | None | Context7 |
| **`deepwiki`** | Streamable HTTP (`https://mcp.deepwiki.com/mcp`) | AI-indexed documentation, wikis, and architecture summaries for open-source GitHub repositories | None | DeepWiki (Streamable HTTP, free) |
| **`memory`** | stdio (`npx -y @modelcontextprotocol/server-memory@2026.7.4`) | Persistent knowledge graph for project facts, design decisions, and architectural notes | `MEMORY_FILE_PATH` pointing to memory store | Official MCP SDK |
| **`rea`** *(opt-in `--with-rea`)* | stdio (`npx -y rea-agents@6.4.0 mcp`) | Reverse engineering of native binaries, APKs, firmware, Electron/JS apps, .NET, WASM/EVM | `REA_MCP_INPUT_SCHEMA_PROFILE=compact` | `morluto/rea` (99.9k ⭐, MIT) |
| **`hybrid-sage`** *(optional sibling repo)* | stdio (`python3 .../hybrid-sage/plugins/mcp_server.py`) | Bidirectional Antigravity <-> OpenCode symbiosis (`fleet_status`, `route_task`, `delegate_local`, `escalate_task`, `manage_handoff`, `airgap_scan`) + `model-router` skill | Optional local OpenCode install | `bioassembly/hybrid-sage` (MIT) |

> **Trimmed Servers & Skills:**
> - `sequential-thinking`, `fetch`, `playwright`: Redundant with Antigravity's native reasoning, `read_url_content`, and `/browser` subagent.
> - `/gpu` (`nvidia-smi` wrapper), `tool-installation` (Python-version-specific filler), duplicate `hybrid-routing` scripts: Pruned to keep the standalone harness lean and 100% hardware-agnostic (no local GPU assumed; cross-harness routing lives in `hybrid-sage`'s `model-router`).

---

## 2. Agent Skills (35 Bundled)

### Engineering & Workflow
- **`grill-me`**: Relentless design-tree interview loop in rounds with concrete defaults to stress-test plans before code is written. (`mattpocock/skills`, 302.6k ⭐, MIT)
- **`domain-modeling`**: Active domain modeling discipline, inline `GLOSSARY.md` maintenance, and ADR authoring when trade-offs crystallize. (`mattpocock/skills`, 302.6k ⭐, MIT)
- **`codebase-design`**: Deep modules vs shallow modules (Ousterhout), high leverage, locality, and seam discipline. (`mattpocock/skills`, 302.6k ⭐, MIT)
- **`to-spec`**: Spec-driven synthesis: converts conversation and codebase context into verified technical specifications. (`mattpocock/skills`, 302.6k ⭐, MIT)
- **`to-tickets`**: Vertical tracer-bullet slicing with blocking dependency chains and expand-contract refactors. (`mattpocock/skills`, 302.6k ⭐, MIT)
- **`agentic-coding`**: Working agreements for coding loops: plan-then-edit, minimal diffs, verify each step.
- **`test-driven-development`**: Red-Green-Refactor iron law: no production code without a failing test first. (`obra/superpowers`, 296k ⭐, MIT)
- **`systematic-debugging`**: 4-phase root-cause debugging: reproduce, hypothesize, test minimally, fix root cause.
- **`verification-before-completion`**: Hard gate against premature "done" claims. Requires executed proof.
- **`using-git-worktrees`**: Safe isolated branches and git worktrees before running invasive refactors. (`obra/superpowers`, 296k ⭐, MIT)
- **`github-repo-best-practices`**: Top-1% standard for README, community health, CI/CD, and release layouts.
- **`git-commit-convention`**: History-first house-style inference, Conventional Commits format, imperative summaries, closing keywords, and amend/force-with-lease safety.
- **`security-audit`**: Stack-agnostic OWASP Top-10 static & dynamic security audit for web applications and APIs.
- **`webapp-testing`**: Playwright-based testing for local dynamic and static web applications. (`anthropics/skills`, 180k ⭐, Apache-2.0)
- **`mcp-builder`**: Guide for designing, developing, and debugging MCP servers in Python and TypeScript. (`anthropics/skills`, 180k ⭐, Apache-2.0)

### Bioinformatics & Scientific Computing
- **`nextflow`**: Builds, runs, tests, and debugs Nextflow DSL2 pipelines, nf-core modules, `nextflow.config`, and SLURM HPC execution. (`K-Dense-AI/scientific-agent-skills`, 47.9k ⭐, Apache-2.0)
- **`pysam`**: Low-level streaming access and manipulation for SAM/BAM/CRAM, VCF/BCF, and FASTA/FASTQ. (`K-Dense-AI/scientific-agent-skills`, 47.9k ⭐, MIT)
- **`biopython`**: Sequence analysis, FASTA/GenBank/PDB parsing, and programmatic NCBI Entrez / PubMed queries. (`K-Dense-AI/scientific-agent-skills`, 47.9k ⭐, Biopython License)
- **`statistical-data-visualization`**: Statistical plot validation, bias detection, and interpretability for scientific reports.
- **`fair-data-principles`**: Enforce and audit FAIR principles, Frictionless data schemas, and domain standards (MIMAG, MIxS) across scientific datasets and pipelines.
- **`pipeline-sketch-results`**: Consolidate and organize outputs from custom multi-step pipelines into a clean, numbered, user-facing `results/` deliverable directory while withholding internal code and secrets.

### Meta & Utility
- **`overnight-explorer`**: Unattended autonomous exploration across codebases, scientific/omics datasets, benchmarks, or research topics — delivering two-line-verified `FINDINGS_REPORT.md`, refuted hypotheses, and a cold-reproducible `ANALYSIS_METHODS.md`.
- **`first-principles-explainer`**: Break down complex bioinformatics, data pipelines, and algorithmic logic from first principles with grounded examples.
- **`skill-acquisition`**: Search trust ladder, vet (stars, recency, security scan), synthesize, and install new skills.
- **`skill-evaluation`**: Benchmark skills and prompts with quantitative A/B comparison.
- **`skill-maker`**: Author and refine skills using Red-Green-Refactor methodology.
- **`web-scraping`**: Extract structured data from web pages, handling pagination and APIs.
- **`pdf-inplace-editing`**: Zero-layout-drift PDF editing and redaction (`pdf_edit.py`).
- **`token-efficiency`**: Context-window and token budget discipline: Serena LSP lookups, targeted grep/glob, slice reads, and subagent isolation.
- **`reverse-engineer-anything`**: Autonomously inspect and reverse-engineer opaque binaries, `.so`/`.dll` libraries, APKs, firmware, Electron/ASAR, minified JS bundles, and WASM/EVM bytecode on demand via the zero-overhead `rea` CLI (`rea-agents@6.4.0`). (`morluto/rea`, 99.9k ⭐, MIT)

### Interactive Slash Commands (Implemented as Skills)
- **`/read-only`**: Explore, analyze, and inspect a codebase in strictly read-only mode (zero file modifications, zero state-altering commands).
- **`/review`**: Read-only code review of working git diff using the `reviewer` subagent.
- **`/red-team`**: Pre-implementation attack on plans using the `skeptic` subagent.
- **`/checkpoint`**: Dump current task state to `NOTES.md` and persist durable facts to `memory` MCP.
- **`/doctor`**: Harness diagnostics suite.

---

## 3. Custom Subagents & CLI Agents

- **`orchestrator`**: Swarm meta-orchestrator. Deconstructs complex initiatives into decoupled workstreams, spawns parallel subagents, and synthesizes outputs.
- **`read-only`**: Read-only codebase explorer, analyst, and advisor (`mainAgent: true`, `subagent: true`).
- **`reviewer`**: Read-only code reviewer evaluating diffs against correctness, security, and repo conventions.
- **`skeptic`**: Adversarial senior engineer attacking plans before implementation (hidden assumptions, failure modes, simpler alternatives).
- **`bioinformatician`**: Specialized persona for Nextflow DSL2, nf-core conventions, Quarto, conda, and ONT/PacBio sequencing workflows.
