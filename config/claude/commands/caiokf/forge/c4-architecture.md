---
name: c4-architecture
description: Generate comprehensive C4 architecture documentation for a codebase using bottom-up analysis.
---

# /c4-architecture — Automated C4 Documentation Generation

Generate comprehensive C4 architecture documentation for an existing codebase using bottom-up analysis.

## Instructions

1. Read the skill guide: `skills/c4/SKILL.md`
2. Follow the 4-phase workflow: Code → Component → Container → Context
3. Load detailed tasks from `skills/c4/references/workflow-phases.md` for each phase
4. Generate documentation into `C4-Documentation/` directory

## Usage

```bash
# Full documentation generation
/c4-architecture

# Only context and container levels
/c4-architecture --levels context,container

# Specific directory
/c4-architecture --target ./src/api
```
