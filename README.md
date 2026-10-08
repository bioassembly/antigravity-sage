# Antigravity State-of-the-Art Harness Recipe

A reproducible, high-performance configuration harness for **Google Antigravity CLI (`agy`)** and **Antigravity 2.0**, engineered to match and exceed the capabilities of modern agentic coding and bioinformatics harnesses.

---

## 🌟 Architecture & Design Philosophy

1. **Native Strengths First**: Antigravity already provides native web search, URL reading, an interactive browser subagent (`/browser`), asynchronous subagents (`/agents`), and deep multi-agent reasoning loops (`/boost`). Redundant MCP servers (e.g. `fetch`, `sequential-thinking`, generic `playwright`) have been pruned to prevent context bloat and latency.
2. **Language Server Protocol (LSP) Intelligence via Serena**: Since Antigravity does not feature a bare `"lsp": true` toggle, LSP capabilities are provided through **Serena MCP** (`oraios/serena`). Serena runs Language Servers across 40+ programming languages (Python, Nextflow, PHP, TypeScript, Bash, R, etc.), exposing IDE-level symbol search, workspace definitions, cross-file reference lookups, and semantic refactoring directly to the agent.
3. **Persistent Project Memory**: Official `@modelcontextprotocol/server-memory` retains durable project architecture choices, user preferences, and conventions across compaction cycles and new sessions.
4. **Autonomous Execution with Strict Safeguards**: Configured with `toolPermission: always-proceed` alongside an anchored Deny list (`rm -rf /`, `mkfs`, raw device writes, unvetted pipe-to-shell scripts, `.git/` protection).

---

## 📦 What is Included

### 1. Model Context Protocol (MCP) Servers
- **`serena`**: Stdio MCP providing full LSP semantic intelligence, symbol jump, and refactoring (`uvx serena-agent start-mcp-server --context antigravity --project-from-cwd --open-web-dashboard false`).
- **`context7`**: Streamable HTTP MCP for real-time framework & library API documentation (`https://mcp.context7.com/mcp`).
- **`deepwiki`**: Streamable HTTP MCP for querying AI-indexed GitHub repository wikis and architectures without credentials (`https://mcp.deepwiki.com/mcp`).
- **`memory`**: Local MCP memory graph for long-term project context (`~/.config/opencode/memory.json`).

### 2. Vetted Agent Skills (25 Total)
- **Core Software Engineering**: `agentic-coding`, `test-driven-development` (obra/superpowers, 296k ⭐), `systematic-debugging`, `verification-before-completion`, `using-git-worktrees` (obra/superpowers), `github-repo-best-practices`, `security-audit`, `webapp-testing` (anthropics/skills, 180k ⭐), `mcp-builder`.
- **Bioinformatics & Scientific Stack**: `nextflow` (K-Dense-AI, 47.9k ⭐), `pysam` (K-Dense-AI), `biopython` (K-Dense-AI), `statistical-data-visualization`, `tool-installation`.
- **Interactive Slash Commands**: `/review` (working diff reviewer), `/red-team` (adversarial skeptic), `/checkpoint` (task state save), `/gpu` (VRAM and inference status), `/doctor` (harness diagnostics).
- **Skill Authoring & Meta**: `skill-acquisition`, `skill-evaluation`, `skill-maker`, `web-scraping`, `pdf-inplace-editing`.

### 3. Custom Subagents (`~/.gemini/config/agents/`)
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
# 1. Clone or copy this repository
git clone <repo-url> ~/Antigravity-best-practices
cd ~/Antigravity-best-practices

# 2. Run the deployment script
bash install.sh
```

### What `install.sh` Does:
1. Deploys `config/mcp_config.json` to `~/.gemini/config/mcp_config.json`.
2. Links all vetted skills into `~/.gemini/config/skills/`.
3. Links custom subagents into `~/.gemini/config/agents/`.
4. Deploys global rules to `~/.gemini/config/AGENTS.md`.
5. Merges autonomous permission settings and security Deny barriers into `~/.gemini/antigravity-cli/settings.json`.
6. Executes `scripts/doctor.sh` to verify every component.

---

## 🔍 Diagnostics & Health Check

To verify your setup at any time:

```bash
bash ~/Antigravity-best-practices/scripts/doctor.sh
```
Or directly inside the Antigravity TUI:
```
/doctor
```

---

## 📋 Directory Structure

```text
Antigravity-best-practices/
├── install.sh                  # One-click deployment script
├── README.md                   # This documentation
├── REGISTRY.md                 # Detailed catalog of all skills, MCPs & agents
├── config/
│   ├── AGENTS.md               # Machine-wide global agent instructions
│   ├── mcp_config.json         # Curated MCP configuration (Serena, Context7, DeepWiki, Memory)
│   └── settings.json           # Settings template with autonomous permissions & deny rules
├── agents/                     # Custom subagents (reviewer, skeptic, bioinformatician)
│   ├── bioinformatician/agent.md
│   ├── reviewer/agent.md
│   └── skeptic/agent.md
├── skills/                     # 25 curated, vetted Agent Skills
└── scripts/
    └── doctor.sh               # Harness diagnostics suite
```
