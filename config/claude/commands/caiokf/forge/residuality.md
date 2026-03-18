---
name: residuality
description: Facilitates a Residuality Theory session — Barry O'Reilly's methodology for stress-testing software architectures through random simulation. Produces a residuality analysis with stressor analysis, contagion matrix, residual architecture, and empirical test.
---

# /residuality — Residuality Theory Session

Facilitate a Residuality Theory session to arrive at a software architecture that survives unpredicted stress through random simulation of the business environment.

## Instructions

1. Read the skill guide: `skills/residuality/SKILL.md`
2. Follow the session flow through all 6 phases (Naïve Architecture → Flow Analysis → Stressor Analysis → Contagion Analysis → Integration → Empirical Test)
3. Load facilitator prompts from `skills/residuality/references/facilitator-prompts.md` for each phase
4. Load deeper theory from `skills/residuality/references/core-theory.md` if participants ask "why does this work?"
5. Generate the output artifact using `skills/residuality/templates/residuality-analysis.md`

## Related Commands

| Command      | When to Use Instead                                          |
| ------------ | ------------------------------------------------------------ |
| `/event-storming`    | Need to discover domain events before stress-testing         |
| `/event-modeling`    | Need to design the full system blueprint first               |
| `/bounded-contexts`  | Need to establish bounded contexts before architectural work |
| `/discovery` | Need to explore the problem space before architecture        |
