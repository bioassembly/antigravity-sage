
## 2026-11-08 — Skill integrity and scoped autonomous learning

- Aligned acquisition and post-task learning: use official docs for one-off gaps;
  install vetted reusable skills when requested or within authorized harness work.
  Removed arbitrary star-count gates as a substitute for inspecting instructions,
  references, license, and compatibility. Existing authorization remains sufficient.
- Replaced default system Python overrides with existing project environments,
  `uv`/venv, or named conda environments; removed hardcoded environment assumptions.
- Repaired absent Nextflow, pysam, Biopython, and MCP guide references using official
  documentation; added local MCP evaluation and behavior-oriented test guidance.
  Preserved upstream attribution and clarified illustrative scientific examples.
- Added dependency-free skill metadata/resource validation before activation,
  four regression tests for the validator, and CI coverage. Corrected repository
  instructions so smoke tests preserve live credentials and use temporary HOME.
- Made review, design interviews, worktrees, and cross-harness escalation proportional
  to the task, with Codex-aware consultation and graceful unavailable-tool fallback.
- Sources: local audit; https://docs.seqera.io/nextflow/;
  https://nf-co.re/docs/developing/overview; https://pysam.readthedocs.io/;
  https://biopython.org/docs/latest/Tutorial/; official MCP SDK repositories and
  https://modelcontextprotocol.io/docs/develop/build-server.
- Hypothesis: resolving broken resource routes and conflicting acquisition rules
  prevents dead-end retrieval and irrelevant installs. Static/link checks and
  isolated activation are the validation for this change; behavioral A/B gains
  remain unmeasured. Behavioral cases are documented in the sibling opencode-sage repository.

### Hybrid SAGE three-harness integration

- Antigravity can proactively partition substantial work into independent free-only
  OpenCode jobs, bounded by the configured concurrency limit, with explicit file
  ownership and parent integration/review. Codex diagnosis uses `consult_codex`;
  Antigravity diagnosis uses `escalate_task`. Child workers do not recurse.
- Source: sibling hybrid-sage tool contracts (`list_worker_models`, `delegate_local`,
  `consult_codex`) and the user's request for a Codex/Antigravity/OpenCode fleet.
- Free-model allowlists describe operator policy, not unlimited quota or local data
  residency. Unavailable workers fall back to direct work without paid rerouting.

## 2026-11-15 — Original upstream packages and reversible shared integration

Complete source packages/resources are pinned in third_party/lock.json. Original Ponytail and grilling text is unchanged. Native skill routing, compiled-guide compatibility aliases, and the independently tested MCP parallel-result correction are recorded outside or alongside the relevant upstream files. Shared installers preserve preferences, local skill overrides, personal plugin files and user notes, and journal explicit Hybrid deactivation including auto-discovered plugins. No model job or provider change is required to update the harness. See docs/shared-sync.md.

Replaced grill-me with the original grill-with-docs package at the user’s request. Both full dependencies, grilling and domain-modeling, remain installed. This combines the design interview with glossary and significant ADR maintenance; installation does not create project documents or invoke a model.
