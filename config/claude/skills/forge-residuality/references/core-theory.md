# Residuality Theory — Core Theory Reference

This reference provides deeper theoretical context for facilitating Residuality Theory sessions. Load when participants ask "why does this work?" or when deeper understanding is needed.

---

## Hyperliminal Systems

A **hyperliminal system** is one where a complicated, ordered system (software) executes inside a complex, disordered context (business environment).

- The software is **ergodic**: its future states can be predicted from its structure
- The business context is **non-ergodic**: its future cannot be predicted from its past
- Traditional engineering assumes both sides are ergodic — this is the foundational error

Software Engineering is the engineering of hyperliminal systems. There is nothing in the history of traditional engineering like this. Importing ideas from bridge-building, manufacturing, or automotive engineering is inappropriate — those disciplines work with stable, ordered environments.

The term *hyperliminal* was coined by Barry O'Reilly specifically to name this challenge, opening up the question of how to solve problems from first principles rather than borrowed assumptions.

---

## Kauffman Networks and NKP

Stuart Kauffman's Random Boolean Networks (1960s) provide the mathematical foundation for why random simulation works.

### The Three Variables

| Variable | Meaning | Software Analogy |
| --- | --- | --- |
| **N** | Number of nodes in the network | Number of components/services |
| **K** | Number of links between nodes | Dependencies between components |
| **P** | Bias — tendency of nodes toward predictable behavior | Interfaces, uniform error handling, consistent patterns |

### How They Interact

- As **N** and **K** rise, the number of attractors rises (more possible states)
- As **P** rises, the number of attractors falls (more predictable behavior)
- **Criticality** is the balance point — resilient to unexpected change, not so complicated it collapses under its own weight

### Software Parallels

- **Low N and K**: Monoliths — few components, few dependencies, limited adaptability
- **High N and K**: Microservices — many components, many dependencies, operational burden
- **High P**: Consistent interfaces, uniform error handling, standardized communication — biases components toward predictable behavior
- Most methodologies (SOLID, DRY, OOP, pattern approaches) are implicitly trying to find the right N, K, P — they just don't have the vocabulary

The incidence matrix from contagion analysis gives a direct view of N and K. The architect's task is to optimize these toward criticality.

---

## Attractors

In any complex system, despite countless possible combinations of individual states, order appears. Systems consistently return to the same relatively small group of recurring states — **attractors**.

- Attractors explain repeating patterns in workplaces, markets, and social systems
- In software, patterns can be seen as attractors
- Attractors provide predictability that is NOT related to individual properties of system elements
- Human examples: sleep, hunger, seasonal economic cycles, market corrections

### Why Attractors Matter for Architecture

The number of potential stressors (things that can happen) is **orders of magnitude greater** than the number of potential attractors. This creates mathematical leverage:

- Each time the architect identifies an attractor and modifies the residue to survive in it, the architecture survives **all stressors** that push the system to that attractor
- This is why random, even unlikely stressors are useful — they may reveal an attractor that many other stressors also lead to
- This is why the architecture begins to survive things it was NOT designed for — the famous "looping" phenomenon

---

## Architectural Walking

The concept of *architectural walking* comes from Gilles Deleuze's idea of learning through repetitive exploration (Difference and Repetition, 1968).

### The Walk Metaphor

The first time you walk a new route, you depend on a map — an objective but reduced description. Each subsequent walk reveals things the map cannot: mosquitos on hot days, slippery paths in winter, angry dogs at certain houses, beautiful sunset views. Walking with different companions reveals different things. Over time, knowledge becomes rich and multilayered — far beyond what any map captures.

### For Architects

- Traditional methods map structure (entities, relationships, components). This is the "map" — useful but thin.
- Architectural walking builds rich, layered understanding through repeated exploration from different angles
- Each stressor triggers a walk — a lightweight re-exploration of the system from a new perspective
- This explains why many different methods (TDD, DDD, event storming, etc.) can all produce good architectures — they are all vehicles for triggering walks
- The unifying feature of good architectural work is that the architect takes enough walks

---

## Stressor Analysis — Deeper Guidance

### Sources of Stressors

The best stressors come from stressing **the abstractions and concepts in the architecture itself**:

- Any entity named with a noun (Customer, Order, Product, Invoice) — these concepts WILL change
- Any process or use case that has been mapped — the mapping hides information
- Any flow that is assumed to be one-directional
- Any actor whose role is assumed to be fixed

External tools for generating business stressors:

- **Business Model Canvas** — stress each box (value proposition, channels, customer segments, revenue streams)
- **PESTLE Analysis** — Political, Economic, Social, Technological, Legal, Environmental
- **Porter's Five Forces** — competitive rivalry, supplier power, buyer power, threat of substitution, threat of new entry

### The Curse of High Dimensionality

People are generally terrible at random simulation. In groups, the simulation centers around highly likely scenarios and consensus — exactly the opposite of what's needed. The facilitator must actively push toward unlikely, imaginative stressors. The apparent structure of traditional methods gives an illusion of coverage while actually producing patchy, biased samples.

### Over-Engineering Concern

A common objection: "Why design for something that might not happen?"

The counter-argument: at least 30% of failed projects fail from things nobody expected. More projects suffer from under-engineering (failing to engage with the context) than over-engineering (too many technical features). A residue does not have to be fully implemented — merely identifying it improves the architecture by revealing potential changes and decoupling points.

---

## Contagion Analysis — The Seven Triggers

The incidence matrix (components × stressors) is a network representation of the hyperliminal boundary — the interface between the complicated software and its complex context.

### Trigger Details

1. **High row totals**: Stressors affecting many components reveal the most dangerous attractors. These stressors have the highest hyperliminal coupling and often point to non-functional concerns (availability, consistency) that need explicit architectural treatment.

2. **High column totals**: Components hit by many stressors may be doing too much. Consider splitting. Alternatively, if the component is genuinely central, invest in redundancy and reliability.

3. **Multiple 1s in a row**: Two components affected by the same stressor are coupled in a way that is invisible during normal operation. This is hyperliminal coupling. It causes contagion — errors that are hard to debug because they cross boundaries nobody knew existed.

4. **Similar column patterns**: Components that have the same response pattern to stress can be combined into a single component, safely reducing N without losing survivability.

5. **Many high numbers**: K is too high across the board. The architecture may need fundamental rethinking — perhaps the pattern or platform choice is unsuitable.

6. **Stressor combinations**: Look at which components are damaged in any one attractor and imagine a second stressor hitting simultaneously. This builds attack trees revealing deeper vulnerabilities.

7. **Zero-total columns**: A component not touched by any stressor is almost certainly under-stressed, not invulnerable. Go back and generate stressors specifically for this area.

---

## FMEA and ATAM

### Failure Mode Effects Analysis (FMEA)

Applied to the near-final architecture to verify technical quality. For each component:

- What happens when it fails?
- What is the effect on the rest of the system?
- How is the failure detected?
- What is the recovery mechanism?

An inability to answer these questions suggests a poorly understood architecture.

### Architecture Trade-off Analysis Method (ATAM)

Used to navigate stakeholder disagreements about which residues to include:

- Which residues are most valuable to which stakeholders?
- Where do residues conflict, requiring trade-offs?
- What are the cost, schedule, and risk implications of including or excluding each residue?

---

## The Empirical Test

What sets Residuality Theory apart from other methodologies is its empirical test.

1. Generate a new list of stressors — ones NEVER used during development
2. Apply them to both the naïve architecture and the residual architecture
3. Count survivors: X (naïve) and Y (residual)
4. Calculate: **Ri = (Y - X) / S**

If Ri > 0, the residual analysis produced measurable improvement. The test can be run iteratively — as Ri approaches 0, diminishing returns indicate the architecture has reached a useful level of criticality.

This is analogous to:
- A **randomized control trial** with the naïve architecture as control
- A **train/test split** in machine learning, with the first stressor list training the architecture and the second testing it

---

## Heuristics

The practical result of Residuality Theory is a set of heuristics for architectural thinking:

1. You cannot map hyperliminal systems
2. You cannot control hyperliminal systems
3. Random simulation is better than requirements, risks, and predictions
4. Flows are better than process or use case mapping
5. Residues replace components or patterns as the unit of architecture
6. Matrices are better than decomposition by pattern or framework
7. No probability or cost until the architecture is explored for weaknesses
