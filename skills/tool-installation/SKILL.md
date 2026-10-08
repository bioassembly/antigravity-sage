---
name: tool-installation
description: Install bioinformatics tools via conda/bioconda/conda-forge, avoid pip failures on Python 3.14
---

## What I do
- Install bioinformatics tools using `conda install -c bioconda -c conda-forge <tool>` instead of pip
- Always check conda availability before falling back to pip
- Avoid pip install for tools with C dependencies (biopython, eggNOG-mapper, etc.) on Python 3.14+
- Verify installation after successful install
- Use shiddharta environment by default unless specified otherwise

## Patterns
```bash
# Always prefer conda over pip for bioinformatics tools
conda run -n shiddharta conda install -c bioconda -c conda-forge <tool>

# Verify installation
conda run -n shiddharta which <binary> || conda run -n shiddharta python -c "import <module>; print('OK')"

# If conda fails, check available versions
conda search <tool> -c bioconda -c conda-forge

# For tools not in conda, try pip as last resort
conda run -n shiddharta pip install <tool>

# Check Python version before installing Python-dependent tools
conda run -n shiddharta python --version
```

## When to use me
- Installing any bioinformatics tool (eggNOG-mapper, Prokka, CheckM2, GTDB-TK, etc.)
- When pip install fails on Python 3.14+ (biopython, psutil, etc.)
- When a tool has C/C++ dependencies
- When the tool is available on bioconda/conda-forge
