---
name: gpu
description: Show local GPU and local-inference server status (VRAM, power, llama-server/unsloth processes). Read-only. Use on /gpu or before starting GPU-heavy jobs.
---

# GPU status (read-only)

1. `nvidia-smi --query-gpu=memory.used,memory.total,power.draw,power.limit,temperature.gpu --format=csv,noheader`
2. `ps aux | grep -E 'llama-server|unsloth|vllm|ollama' | grep -v grep`

Report:
- VRAM used / total (and whether a model is loaded)
- Which inference servers are up (PIDs only)
- One line: safe to start another GPU process? (no if VRAM used > 90%)

CRITICAL: report only. Never kill, restart, or signal these processes — that terminates live model sessions.
