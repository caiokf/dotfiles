---
description: Use when stress-testing software architecture with Residuality Theory (Barry O'Reilly) — random simulation to discover what survives unpredicted stress. For new architecture design, hidden coupling discovery, or production readiness assessment. Triggers on "residuality", "stress-test architecture", "contagion analysis", "architecture resilience".
---

# Residuality Theory

This skill provides knowledge and facilitation guidance for Residuality Theory sessions — a methodology developed by Barry O'Reilly that uses random simulation of stress to produce software architectures capable of surviving unanticipated changes in complex business environments.

## When to Use

This skill should be used when:

- Designing the architecture of a new system (greenfield)
- Stress-testing an existing architecture for hidden weaknesses
- Discovering invisible coupling between components
- Preparing a system for an uncertain or rapidly changing business context
- Questioning whether current abstractions and boundaries will hold over time
- A team is over-reliant on pattern-based or requirements-driven architecture

## Core Philosophy

Residuality Theory rests on a counter-intuitive claim: **random simulation of stress produces better architectures than prediction, requirements analysis, reuse of patterns, or reactive change management.**

Software operates in _hyperliminal_ environments — complicated, ordered software executing inside complex, disordered business contexts. The business context is non-ergodic: its future cannot be predicted from its past. Traditional engineering methods (requirements, risk, patterns) were imported from disciplines where the environment is stable. In software, they lead to under-engineering, over-engineering, or both.

The goal of the architect is **criticality** — the right balance of structure that allows the system to survive unknown stressors — not correctness.

## Key Concepts

| Concept                   | Definition                                                                                                                                                                                                          |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Stressor**              | Any fact about the context currently unknown to you. NOT just a failure mode. Includes business changes, regulatory shifts, conceptual breakdowns, market moves.                                                    |
| **Attractor**             | A recurring state that a complex system returns to. Business systems shift between attractors over time. The number of attractors is orders of magnitude smaller than the number of possible stressors.             |
| **Residue**               | What is left over of the architecture after it is exposed to a stressor. The fundamental unit of software architecture. Each residue describes changes needed for the architecture to survive in a given attractor. |
| **Naïve architecture**    | The simplest architecture that solves the stated problem. The starting point — intentionally simple, not pattern-loaded.                                                                                            |
| **Residual architecture** | The integrated collection of all residues, compressed into a single coherent architecture.                                                                                                                          |
| **Criticality**           | The point where the architecture begins to survive stressors it was NOT designed for. Indicated by "looping" — new stressors are already survived by existing residues or combinations of residues.                 |
| **Hyperliminal coupling** | Invisible coupling between components that is only revealed when the system is stressed. Causes contagion — errors that ripple across component boundaries.                                                         |
| **Contagion**             | How stress spreads through the system. Analyzed using incidence matrices.                                                                                                                                           |
| **NKP**                   | N = number of nodes/components, K = number of links between them, P = bias/predictability of node behavior. Criticality is finding the right balance.                                                               |
| **Residual Index (Ri)**   | Empirical measure: Ri = (Y - X) / S, where Y = stressors survived by residual architecture, X = stressors survived by naïve architecture, S = total stressors. Ri > 0 = improvement.                                |

## Stressors Are NOT Risks

This distinction is critical. Do not conflate stressors with traditional concepts:

| Concept           | Why It Differs from Stressors                                                                 |
| ----------------- | --------------------------------------------------------------------------------------------- |
| Requirements      | Snapshot of one stakeholder's model at one moment. Subject to change.                         |
| Risks             | Require assigned probability and impact — numbers that are usually just opinions.             |
| Scenarios         | Limited to what stakeholders think is likely. Lack lateral thinking.                          |
| Edge cases        | Assume the current abstraction is correct and anomalies are at the edges.                     |
| Chaos engineering | Tests running production infrastructure. Linear, concrete, not accessible at design time.     |
| Resilience        | About returning to the same attractor. Residuality is about transitioning between attractors. |

**Stressor rules:**

1. No use of probability
2. All stressors go in the list, no matter how unlikely
3. Use as many sources as possible
4. Stress business concepts and abstractions, not just infrastructure
5. Survives is strictly binary — Yes or No. Document friction, manual effort, or partial survival in the Residue column, not as a qualified "Yes*" or "Maybe"

## Session Flow

### Phase 1: Establish the Naïve Architecture (2-3 exchanges)

Understand or define the simplest architecture that solves the stated problem. This is the starting point — it should be intentionally simple. If working with an existing system, describe its current state as the naïve architecture.

### Phase 2: Flow Analysis (3-5 exchanges)

Map the movement of data between actors in the system. Actors can be people, groups, companies, or software components. Describe the system as a network of flows, NOT as processes or use cases. Flow analysis avoids the trap of decomposition by process steps.

### Phase 3: Stressor Analysis (10-15 exchanges)

The core of the session. Randomly simulate the business environment by generating stressors — things that could happen that have not been considered. Work through:

- **Concepts and abstractions** — What if "Customer" means something different? What if "Order" has properties we haven't imagined?
- **Actors and relationships** — What if an actor's role changes? What if a new actor appears?
- **Flows** — What if a flow reverses? What if a flow that doesn't exist today needs to?
- **Business context** — Use PESTLE (Political, Economic, Social, Technological, Legal, Environmental) as a sweep: antitrust action, recession, cultural shifts, supply chain disruption, regulatory change, climate impact. Also: competitors, market shifts, mergers, growth
- **Technology context** — Only after business stressors are thoroughly explored

For each stressor, identify:

1. The **attractor** it pushes the business system toward
2. Whether the current architecture **survives** in that attractor
3. What the **residue** looks like — what changes to the architecture are needed
4. How the stressor would be **detected**

Continue until **criticality indicators** appear:

- New stressors loop to existing residues
- It becomes difficult to generate stressors not already survived
- Combinations of residues handle novel situations

### Phase 4: Contagion Analysis (5-7 exchanges)

Build an incidence matrix: components as columns, stressors as rows. Place 1 where a stressor affects a component, 0 where it does not. Analyze using the seven triggers:

1. **High row totals** — stressors with widest impact, highest hyperliminal coupling
2. **High column totals** — components most sensitive to stress, may need splitting
3. **Multiple 1s in a row** — reveals hidden coupling between components (hyperliminal coupling)
4. **Similar column patterns** — components that respond to stress the same way can be combined
5. **Many high numbers overall** — K is too high, may need architectural rethinking
6. **Stressor combinations** — what happens if two stressors hit simultaneously?
7. **Zero-total columns** — components not touched by any stressor (under-stressed, not invulnerable)

Use the matrix to optimize N, K, and P toward criticality.

### Phase 5: Integration & Residual Architecture (3-5 exchanges)

Compress all residues into a single coherent architecture. Apply FMEA (Failure Mode Effects Analysis) and ATAM (Architecture Trade-off Analysis Method) as final engineering checks. The residual architecture should make it easy for the software to move between residues as the business context shifts between attractors.

Build a **residual incidence matrix** — the same stressors against the new components — to verify that mean vulnerability has decreased. Comparing the naïve matrix (Phase 4) with the residual matrix demonstrates the K reduction visually.

### Phase 6: Empirical Test (2-3 exchanges)

Generate a NEW list of stressors never used in the analysis. Apply them to both the naïve and residual architectures. Count survivors using strict binary Yes/No — no "Maybe" or partial answers. Calculate the Residual Index:

**Ri = (Y - X) / S** where -1 ≤ Ri ≤ 1

- Y = stressors survived by residual architecture
- X = stressors survived by naïve architecture
- S = total new stressors

Ri > 0 indicates positive movement toward criticality.

## Facilitation Principles

- The goal is criticality, not correctness
- Use lateral thinking — fill gaps with imagination, not just analysis
- Dare to generate ridiculous stressors — mathematical leverage makes them useful
- Stress business concepts and abstractions first, infrastructure second
- Do not filter stressors by probability — all go on the list
- Move quickly — precision is impossible in complex systems and not the goal
- Structure should constantly collapse and reform; do not defend early abstractions
- A residue does not have to be fully implemented — investigating it has value even if deferred
- Technical architects generating only technical stressors is a warning sign

## Output Artifact

Generate a markdown document using `templates/residuality-analysis.md` containing:

1. Naïve architecture description
2. Flow analysis (actors and flows)
3. Stressor analysis table (stressor → attractor → residue → changes)
4. Criticality assessment
5. Incidence/contagion matrix (naïve)
6. Hyperliminal coupling findings
7. Residual architecture description with residual incidence matrix
8. Empirical test results (Residual Index)
9. Facilitator log — key prompts used and example exchanges
10. Heuristics and next steps

## References

| File                                | Content                                                                  |
| ----------------------------------- | ------------------------------------------------------------------------ |
| `references/facilitator-prompts.md` | Detailed facilitator prompts for each session phase                      |
| `references/core-theory.md`         | Deeper theory: Kauffman networks, attractors, NKP, architectural walking |
| `templates/residuality-analysis.md` | Output template for the analysis artifact                                |
