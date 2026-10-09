# Antigravity Skills & MCP Registry

A curated registry of state-of-the-art skills, custom subagents, and MCP servers tailored for bioinformatics, genomics pipelines, scientific software engineering, and general software engineering.

## 1. Model Context Protocol (MCP) Servers

| Server Name | Transport | Purpose | Credentials / Env | Provenance & Quality |
|---|---|---|---|---|
| **`serena`** | stdio (`uvx serena-agent start-mcp-server --context antigravity --project-from-cwd --open-web-dashboard false`) | LSP-level code intelligence (find symbols, jump to references/definitions, symbol outline, semantic edits) across 40+ languages | None | `oraios/serena` (30.1k ⭐, MIT/GPL-3.0) |
| **`context7`** | Streamable HTTP (`https://mcp.context7.com/mcp`) | Up-to-date documentation and library API references | None | Context7 |
| **`deepwiki`** | Streamable HTTP (`https://mcp.deepwiki.com/mcp`) | AI-indexed documentation, wikis, and architecture summaries for open-source GitHub repositories | None | DeepWiki (Streamable HTTP, free) |
| **`memory`** | stdio (`npx -y @modelcontextprotocol/server-memory@2026.7.4`) | Persistent knowledge graph for project facts, design decisions, and architectural notes | `MEMORY_FILE_PATH` pointing to memory store | Official MCP SDK |

> **Trimmed Servers:**
> - `sequential-thinking`: Trimmed. Frontier models natively perform deep reasoning and chain-of-thought without requiring tool-call overhead.
> - `fetch`: Trimmed. Redundant with Antigravity's built-in `read_url_content`.
> - `playwright`: Trimmed. Redundant with Antigravity's built-in `/browser` subagent.

---

## 2. Agent Skills

### Engineering & Workflow
- **`agentic-coding`**: Working agreements for coding loops: plan-then-edit, minimal diffs, verify each step.
- **`test-driven-development`**: Red-Green-Refactor iron law: no production code without a failing test first. (`obra/superpowers`, 296k ⭐, MIT)
- **`systematic-debugging`**: 4-phase root-cause debugging: reproduce, hypothesize, test minimally, fix root cause.
- **`verification-before-completion`**: Hard gate against premature "done" claims. Requires executed proof.
- **`using-git-worktrees`**: Safe isolated branches and git worktrees before running invasive refactors. (`obra/superpowers`, 296k ⭐, MIT)
- **`github-repo-best-practices`**: Top-1% standard for README, community health, CI/CD, and release layouts.
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

### Meta & Utility
- **`first-principles-explainer`**: Break down complex bioinformatics, data pipelines, and algorithmic logic from first principles with grounded real-world examples.
- **`skill-acquisition`**: Search trust ladder, vet (stars, recency, security scan), synthesize, and install new skills.
- **`skill-evaluation`**: Benchmark skills and prompts with quantitative comparison.
- **`skill-maker`**: Author and refine skills using Red-Green-Refactor methodology.
- **`web-scraping`**: Extract structured data from web pages, handling pagination and APIs.
- **`pdf-inplace-editing`**: Zero-layout-drift PDF editing and redaction.

### Interactive Slash Commands (Implemented as Skills)
- **`/review`**: Read-only code review of working git diff using the reviewer subagent.
- **`/red-team`**: Pre-implementation attack on plans using the skeptic subagent.
- **`/checkpoint`**: Dump current state to `NOTES.md` and push facts to the memory MCP.
- **`/gpu`**: Inspect NVIDIA GPU utilization and running model processes (read-only).

---

## 3. Custom Subagents

- **`reviewer`**: Read-only code reviewer evaluating diffs against correctness, security, and repo conventions.
- **`skeptic`**: Adversarial senior engineer attacking plans before implementation (hidden assumptions, failure modes, simpler alternatives).
- **`bioinformatician`**: Specialized persona for Nextflow DSL2, nf-core conventions, Quarto, conda, and ONT/PacBio sequencing workflows.
