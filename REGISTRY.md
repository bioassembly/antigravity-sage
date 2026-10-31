# Antigravity Skills & MCP Registry

A curated registry of state-of-the-art skills, custom subagents, and MCP servers tailored for bioinformatics, genomics pipelines, scientific software engineering, and general software engineering.

## 1. Model Context Protocol (MCP) Servers

| Server Name | Transport | Purpose | Credentials / Env | Provenance & Quality |
|---|---|---|---|---|
| **`serena`** | stdio (`uvx serena-agent start-mcp-server --context antigravity --project-from-cwd --open-web-dashboard false`) | LSP-level code intelligence (find symbols, jump to references/definitions, symbol outline, semantic edits) across 40+ languages | None | `oraios/serena` (30.1k ⭐, MIT/GPL-3.0) |
| **`context7`** | Streamable HTTP (`https://mcp.context7.com/mcp`) | Up-to-date documentation and library API references | None | Context7 |
| **`deepwiki`** | Streamable HTTP (`https://mcp.deepwiki.com/mcp`) | AI-indexed documentation, wikis, and architecture summaries for open-source GitHub repositories | None | DeepWiki (Streamable HTTP, free) |
| **`memory`** | stdio (`npx -y @modelcontextprotocol/server-memory@2026.7.4`) | Persistent knowledge graph for project facts, design decisions, and architectural notes | `MEMORY_FILE_PATH` pointing to memory store | Official MCP SDK |
| **`rea`** | stdio (`npx -y rea-agents@6.4.0 mcp`) | Reverse engineering of native binaries, APKs, firmware, Electron/JS apps, .NET, WASM/EVM | `REA_MCP_INPUT_SCHEMA_PROFILE=compact` | `morluto/rea` (99.9k ⭐, MIT) |

> **Trimmed Servers:**
> - `sequential-thinking`: Trimmed. Frontier models natively perform deep reasoning and chain-of-thought without requiring tool-call overhead.
> - `fetch`: Trimmed. Redundant with Antigravity's built-in `read_url_content`.
> - `playwright`: Trimmed. Redundant with Antigravity's built-in `/browser` subagent.

---

## 2. Agent Skills

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
- **`git-commit-convention`**: History-first house-style inference, Conventional Commits format, imperative summaries, closing keywords, and amend/force-with-lease safety. (Conventional Commits standard)
- **`security-audit`**: OWASP Top-10 static audit for web applications and APIs.
- **`webapp-testing`**: Playwright-based testing for local dynamic and static web applications. (`anthropics/skills`, 180k ⭐, Apache-2.0)
- **`mcp-builder`**: Guide for designing, developing, and debugging MCP servers in Python and TypeScript. (`anthropics/skills`, 180k ⭐, Apache-2.0)

### Bioinformatics & Scientific Computing
- **`nextflow`**: Builds, runs, tests, and debugs Nextflow DSL2 pipelines, nf-core modules, nextflow.config, and SLURM HPC execution. (`K-Dense-AI/scientific-agent-skills`, 47.9k ⭐, Apache-2.0)
- **`pysam`**: Low-level streaming access and manipulation for SAM/BAM/CRAM, VCF/BCF, and FASTA/FASTQ. (`K-Dense-AI/scientific-agent-skills`, 47.9k ⭐, MIT)
- **`biopython`**: Sequence analysis, FASTA/GenBank/PDB parsing, and programmatic NCBI Entrez / PubMed queries. (`K-Dense-AI/scientific-agent-skills`, 47.9k ⭐, Biopython License)
- **`statistical-data-visualization`**: Statistical plot validation, bias detection, and interpretability for scientific reports.
- **`tool-installation`**: Clean conda/bioconda/conda-forge environment installs, avoiding pip breakage.
- **`fair-data-principles`**: Enforce and audit FAIR principles (Findable, Accessible, Interoperable, Reusable), Frictionless data schemas, and domain standards (MIMAG, MIxS) across scientific datasets and pipelines.
- **`pipeline-sketch-results`**: Consolidate and organize outputs from custom, multi-step sketch/bash/python pipelines into a clean, numbered, user-facing `results/` directory while strictly withholding proprietary code and internal environments.

### Meta & Utility
- **`first-principles-explainer`**: Break down complex bioinformatics, data pipelines, and algorithmic logic from first principles with grounded real-world examples.
- **`skill-acquisition`**: Search trust ladder, vet (stars, recency, security scan), synthesize, and install new skills.
- **`skill-evaluation`**: Benchmark skills and prompts with quantitative comparison.
- **`skill-maker`**: Author and refine skills using Red-Green-Refactor methodology.
- **`web-scraping`**: Extract structured data from web pages, handling pagination and APIs.
- **`pdf-inplace-editing`**: Zero-layout-drift PDF editing and redaction.
- **`token-efficiency`**: Context-window and token budget discipline: targeted grep/glob, slice reads, Serena LSP lookups, subagent isolation, and compaction hygiene.
- **`hybrid-routing`**: Adaptive cognitive tier routing: dispatch abstract/conceptual reasoning to frontier models while offloading deterministic instruction tasks to local AI workers to preserve tokens. Features toggle on/off.
- **`reverse-engineer-anything`**: Decompile/disassemble binaries, APKs, firmware, Electron apps, WASM/EVM via REA MCP (pinned `rea-agents@6.4.0`, compact schema). No-source targets only; native decompile needs Ghidra (not installed). (`morluto/rea`, 99.9k ⭐, MIT)

### Interactive Slash Commands (Implemented as Skills)
- **`/read-only`**: Instruct the agent to explore, analyze, and inspect the codebase in strictly read-only mode (zero file modifications, zero destructive commands).
- **`/review`**: Read-only code review of working git diff using the reviewer subagent.
- **`/red-team`**: Pre-implementation attack on plans using the skeptic subagent.
- **`/checkpoint`**: Dump current state to `NOTES.md` and push facts to the memory MCP.
- **`/gpu`**: Inspect NVIDIA GPU utilization and running model processes (read-only).
- **`/doctor`**: Harness diagnostics suite.

---

## 3. Custom Subagents & CLI Agents

- **`orchestrator`**: Swarm meta-orchestrator. Deconstructs complex initiatives into decoupled workstreams, dynamically spawns and coordinates specialized parallel subagents, and synthesizes outputs.
- **`read-only`**: Read-only codebase explorer, analyst, and advisor. Explores files, navigates symbols via Serena LSP, and explains architectures with strictly zero file edits or destructive commands (`mainAgent: true`, `subagent: true`).
- **`reviewer`**: Read-only code reviewer evaluating diffs against correctness, security, and repo conventions.
- **`skeptic`**: Adversarial senior engineer attacking plans before implementation (hidden assumptions, failure modes, simpler alternatives).
- **`bioinformatician`**: Specialized persona for Nextflow DSL2, nf-core conventions, Quarto, conda, and ONT/PacBio sequencing workflows.
