---
name: workflow
description: Facilitates interactive BPMN workflow discovery sessions to model business processes through guided conversation and iterative refinement. Supports both new process discovery and refinement of existing .bpmn files.
---

# /workflow — BPMN Workflow Discovery

Facilitate an interactive session to discover, model, and refine business processes as BPMN diagrams.

## Instructions

1. Read the skill guide: `skills/bpmn-workflow/SKILL.md`
2. Determine mode: new process or refining existing `.bpmn` file
3. Follow the session flow through all 9 phases
4. Load facilitator prompts from `skills/bpmn-workflow/references/facilitator-prompts.md` for each phase
5. Generate BPMN 2.0 XML files progressively after each major phase

## Invocation

```
/workflow                           # New process discovery
/workflow order-fulfillment.bpmn    # Refine existing file
```

## Related Commands

| Command      | When to Use Instead                                    |
| ------------ | ------------------------------------------------------ |
| `/bpmn`      | Already know exactly what to diagram                   |
| `/discovery` | Exploring a domain without a specific process in mind  |
| `/event-storming`    | Focusing on events and eventual consistency            |
| `/bounded-contexts`  | Identifying service boundaries before process modeling |
