---
name: discovery
description: Facilitates open-ended domain discovery sessions to explore and understand a problem space, identify core concepts, workflows, business rules, and pain points before committing to specific modeling techniques.
---

# /discovery — Domain Discovery Facilitation

Facilitate an open-ended Domain Discovery session to explore and understand a problem space before committing to specific modeling techniques.

## Instructions

1. Read the skill guide: `skills/domain-discovery/SKILL.md`
2. Follow the session flow through all 13 phases (areas to explore, not a strict sequence)
3. Load facilitator prompts from `skills/domain-discovery/references/facilitator-prompts.md` for each phase
4. When conversation stalls or goes sideways, consult `skills/domain-discovery/references/recovery-techniques.md`
5. At synthesis, recommend the appropriate next technique based on findings

## Technique Recommendations

| Finding                               | Recommended Next Step |
| ------------------------------------- | --------------------- |
| Complex workflows with many events    | `/event-storming`     |
| Need to design a system end-to-end    | `/event-modeling`     |
| Multiple teams or systems interacting | `/bounded-contexts`   |
| Production readiness concerns         | `/residuality`        |

## Related Commands

| Command   | When to Use Instead                              |
| --------- | ------------------------------------------------ |
| `/event-storming` | Already know you want Event Storming             |
| `/define` | Exploring a product idea, not a technical domain |
