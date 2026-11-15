# Antigravity SAGE

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

> **Antigravity SAGE (State-of-the-Art Agentic Genomics & Engineering Harness)**: A reproducible, high-performance configuration harness for **Google Antigravity CLI (`agy`)** and **Antigravity 2.0**, engineered to match and exceed the capabilities of modern agentic coding and bioinformatics harnesses.

---

## 🌟 Architecture & Design Philosophy

1. **Native Strengths First**: Antigravity already provides native web search, URL reading, checkpoints/NOTES.md, an interactive browser subagent (`/browser`), asynchronous subagents (`/agents`), and deep multi-agent reasoning loops (`/boost`). Redundant MCP servers (`fetch`, `sequential-thinking`, `playwright`, `memory`, `openaiDeveloperDocs`) have been pruned to prevent tool-schema bloat.
2. **Language Server Protocol (LSP) Intelligence via Serena**: Since Antigravity does not feature a bare `"lsp": true` toggle, LSP capabilities are provided through **Serena MCP** (`oraios/serena`). Serena runs Language Servers across 40+ programming languages (Python, Nextflow, PHP, TypeScript, Bash, R, etc.), exposing IDE-level symbol search, workspace definitions, cross-file reference lookups, and semantic refactoring directly to the agent.
3. **Automatic Tiered Skill Loading (`sage-skill-router`)**: Keeps 9 universal core skills (+ `skills.local/` overrides) active at startup and routes the remaining 32 domain skills from `~/.gemini/config/skills-catalog/` automatically via `SessionStart` + `PreInvocation` workspace/prompt signals (`--all-skills` activates all 41 directly). Missing reusable workflows are automatically vetted and installed into `skills.local/` via `skill-acquisition`.
4. **Existing Permission Choices**: Installation preserves the user's configured autonomy and permission settings. The settings template adds no permission defaults.

---

## 📦 What is Included

### 1. Model Context Protocol (MCP) Servers
- **`serena`**: Stdio MCP for symbol search and refactoring, pinned to `serena-agent==2.1.0` with the native Antigravity tool interface. Project selection occurs when needed.
- **`context7`**: Streamable HTTP MCP for real-time framework & library API documentation (`https://mcp.context7.com/mcp`).
- **`deepwiki`**: Streamable HTTP MCP for querying AI-indexed GitHub repository wikis and architectures without credentials (`https://mcp.deepwiki.com/mcp`).
- **`rea`**: Optional reverse-engineering MCP (`--with-rea`, pinned `rea-agents@6.4.0`). Native decompilation needs Ghidra, which is not bundled.
- **`hybrid-sage`**: Disabled by default during install to avoid unnecessary routing token overhead; pass `--enable-hybrid` to opt in.

### 2. Vetted Agent Skills (41 Bundled + Gitignored `skills.local/` Support)
- **Core Software Engineering**: `agentic-coding`, `grill-with-docs`, `domain-modeling`, `codebase-design`, `to-spec`, `to-tickets` (`mattpocock/skills`, 302.6k ⭐), `git-commit-convention`, `test-driven-development` (`obra/superpowers`, 296k ⭐), `systematic-debugging`, `verification-before-completion`, `using-git-worktrees` (`obra/superpowers`), `github-repo-best-practices`, `security-audit`, `webapp-testing` (`anthropics/skills`, 180k ⭐), `mcp-builder`.
- **Bioinformatics & Scientific Stack**: `nextflow` (K-Dense-AI, 47.9k ⭐), `pysam` (K-Dense-AI), `biopython` (K-Dense-AI), `statistical-data-visualization`, `pipeline-sketch-results`, `fair-data-principles`, `first-principles-explainer`.
- **Autonomous Reverse Engineering**: `reverse-engineer-anything` (morluto/rea, 99.9k ⭐, MIT) — automatically detects opaque binaries, `.so`/`.dll` libraries, APKs, Electron/ASAR bundles, firmware, and minified JS during codebase exploration and runs the zero-context-overhead `rea` CLI on demand without manual invocation.
- **Interactive Slash Commands**: `/read-only` (safe inspection/exploration mode), `/review` (working diff reviewer), `/red-team` (adversarial skeptic), `/checkpoint` (task state save), `/doctor` (harness diagnostics).
- **Autonomous Exploration & Meta**: `overnight-explorer` (unattended multi-branch research/code/data discovery while away), `skill-acquisition`, `skill-evaluation`, `skill-maker`, `token-efficiency`, `web-scraping`, `pdf-inplace-editing` *(plus `model-router` when optional sibling `hybrid-sage` is present, and private machine-only skills placed in gitignored `skills.local/`)*.

### 3. Custom Subagents & CLI Agents (`~/.gemini/config/agents/`)
- **`orchestrator`**: Autonomous swarm meta-orchestrator. Deconstructs complex initiatives into decoupled workstreams, dynamically spawns and coordinates specialized parallel subagents, and synthesizes outputs.
- **`read-only`**: Read-only codebase explorer, analyst, and architecture advisor (strictly zero file edits or destructive commands).
- **`reviewer`**: Read-only code reviewer evaluating diffs against correctness bugs, security issues, and repo conventions.
- **`skeptic`**: Adversarial senior engineer attacking implementation plans before writing code (hidden assumptions, failure modes, simpler alternatives).
- **`bioinformatician`**: Specialized persona for Nextflow DSL2, nf-core conventions, Quarto reporting, conda environments, and ONT/PacBio sequencing workflows.

### 4. Global Rules (`~/.gemini/config/AGENTS.md`)
Machine-wide agent protocol enforcing:
- Progressive skill activation
- Vetting ladder and security bar for acquired skills
- Verification-before-completion hard gate
- Minimal diff discipline and genomics environment standards

---

## 🚀 One-Command Installation & Replication

To install or reproduce this harness on any machine or server:

```bash
# 1. Clone this repository
git clone https://github.com/bioassembly/antigravity-sage.git
cd antigravity-sage

# 2. Run the deployment script
bash install.sh
```

### What `install.sh` Does:
1. Merges `config/mcp_config.json` into the live config (retiring unmodified obsolete default servers while preserving custom registrations and existing on/off choices; `hybrid-sage` disabled by default unless `--enable-hybrid` is passed).
2. Links core skills + `skills.local/` overrides into `~/.gemini/config/skills/`, stages domain catalog skills + `routing.json` under `~/.gemini/config/skills-catalog/`, and installs `sage-skill-router` (`--all-skills` installs all 41 directly).
3. Links custom subagents into `~/.gemini/config/agents/`.
4. Merges shared rules into `~/.gemini/config/AGENTS.md`, preserving personal notes.
5. Preserves `~/.gemini/antigravity-cli/settings.json` permission choices.
6. Journals managed files and prints a restore command. Run diagnostics separately; installation starts no model or Hybrid jobs.

---

## 🔍 Diagnostics & Health Check

To verify your setup at any time:

```bash
bash scripts/doctor.sh
```
Or directly inside the Antigravity TUI:
```
/doctor
```

---

## 📋 Directory Structure

```text
antigravity-sage/
├── .gitignore                  # Git ignore rules for credentials, caches & runtime
├── LICENSE                     # MIT License
├── install.sh                  # One-click deployment script
├── README.md                   # This documentation
├── REGISTRY.md                 # Detailed catalog of all skills, MCPs & agents
├── config/
│   ├── AGENTS.md               # Machine-wide global agent instructions
│   ├── mcp_config.json         # Curated MCP configuration (Serena, Context7, DeepWiki, optional REA)
│   ├── skill-routing.json      # Tiered Core (9) vs On-Demand Catalog (32) skill routing rules
│   └── settings.json           # Empty defaults; existing permission choices survive
├── plugins/
│   └── sage-skill-router/      # SessionStart + PreInvocation workspace/prompt skill auto-router
├── agents/                     # Custom subagents & CLI agents (orchestrator, read-only, reviewer, skeptic, bioinformatician)
│   ├── bioinformatician/agent.md
│   ├── orchestrator/agent.md
│   ├── read-only/agent.md
│   ├── reviewer/agent.md
│   └── skeptic/agent.md
├── skills/                     # 41 curated, hardware-portable Agent Skills
├── skills.local/               # (Optional, gitignored) Private machine-only skills
└── scripts/
    └── doctor.sh               # Harness diagnostics suite
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
Bundled upstream skills retain their own terms; see [third-party notices](THIRD_PARTY_NOTICES.md).


## Maintaining skill quality

Run `python3 scripts/validate-skills.py` before activating skill changes. It checks
required metadata and local Markdown resource links, including inline guide paths.
Scientific skills link to official version-aware documentation instead of referring
to guides that are absent from this repository. Test examples in the actual project
environment; a link check does not establish scientific correctness or model quality.

Skill acquisition follows demonstrated reusable needs and existing authorization.
A missing skill can be handled with official documentation directly. Existing
project environments, `uv`/venv, or named conda environments are preferred for Python.
Optional Hybrid SAGE routing can connect Antigravity, OpenCode, and Codex when the
corresponding workers are configured; provider privacy and cost are checked rather
than inferred from the harness name.

## 2026-11-15 shared upstream refresh

Original Ponytail and grill-with-docs with full grilling/domain-modeling dependencies, refreshed pinned upstream packages, native RTK integration, reversible activation, and disabled-Hybrid handling are documented in [docs/shared-sync.md](docs/shared-sync.md). Use the new installer with `--disable-hybrid` to honor an off choice across MCP and auto-discovered plugin entrypoints. No worker or unrelated package installer runs automatically. Existing provider/model/permission settings and personal skills are preserved.
