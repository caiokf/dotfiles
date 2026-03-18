# Residuality Theory — Facilitator Prompts

Detailed prompts organized by session phase. Load these progressively during facilitation. The prompts are designed to trigger _architectural walks_ — repeated explorations that build layered understanding, not linear interrogation.

---

## Phase 1: Establish the Naïve Architecture

The naïve architecture is the simplest starting point. It should solve the stated problem without patterns, frameworks, or defensive design. If the participant wants to use a specific pattern, challenge them to justify it through stressors instead.

```
FACILITATOR PROMPTS:
- "Describe the simplest architecture that solves this problem. A single component with in-memory storage is fine."
- "What does the system need to do in the most basic terms?"
- "Strip away any patterns or frameworks — what's the bare minimum?"
- "If you had to build this in a weekend, what would it look like?"
- "Is this a greenfield design, an existing system, or post-incident?"
```

If working with an existing system:

```
FACILITATOR PROMPTS:
- "Describe the current architecture as it actually is — not as it was designed to be."
- "What are the main components and how do they connect?"
- "What does the system do today that matters most to the business?"
```

---

## Phase 2: Flow Analysis

Map data flows between actors. Avoid process diagrams or use cases — these impose structure prematurely and hide information. A flow is simply the movement of information between two actors.

```
FACILITATOR PROMPTS:
- "Who or what are the actors in this system? People, groups, companies, software components."
- "When data moves between any two actors, that's a flow. Let's map them all."
- "What information does [Actor A] send to [Actor B]? What triggers it?"
- "Are there any flows that go in the opposite direction?"
- "Are there actors outside the system boundary that send or receive data?"
- "Let's not describe processes — just movements of information between actors."
```

Build a simple list or network of actors and flows. This becomes the foundation to stress.

---

## Phase 3: Stressor Analysis

This is the core of the session. The goal is random simulation — generating stressors broadly and laterally, not systematically checking categories. Move quickly. Do not assess probability. Do not filter. Everything goes on the list.

### Stressing Concepts and Abstractions

Start here. This is where the most architecturally significant discoveries happen. Most developers skip this and jump to infrastructure — redirect them.

```
FACILITATOR PROMPTS:
- "Let's look at the concept of [entity — e.g., Customer, Order, Product]. What if it means something different than we think?"
- "Is a [Customer] always going to be the same? Can we imagine a situation where [Customer] has completely different properties or behaviors?"
- "What if a business customer wants to use this — not an individual? What changes?"
- "What if the concept of [Order] needs to split into two different things?"
- "What abstraction are we most confident about? Let's try to break it."
- "What noun appears most in our architecture? That's probably our biggest risk."
```

### Stressing Actors and Relationships

```
FACILITATOR PROMPTS:
- "What if [Actor]'s role changes? What if they take on responsibilities we haven't considered?"
- "What if a new type of actor appears that doesn't fit our current model?"
- "What if two actors that are separate today need to become one? Or one needs to split?"
- "What if the relationship between [Actor A] and [Actor B] reverses?"
```

### Stressing Flows

```
FACILITATOR PROMPTS:
- "What if this flow needs to go in the other direction?"
- "What if a flow that doesn't exist today needs to exist tomorrow?"
- "What if this flow needs to happen 1000x faster? Or needs to carry completely different data?"
- "What if this flow needs to be interrupted or paused partway through?"
```

### Stressing the Business Context

This is where lateral thinking matters most. The architect must engage with the wider world the software lives in. Use a **PESTLE sweep** to ensure coverage across all dimensions, then go lateral.

```
FACILITATOR PROMPTS (PESTLE sweep):
- POLITICAL: "What if antitrust action forces structural changes? What if lobbying from incumbents changes the rules?"
- ECONOMIC: "What if a recession cuts discretionary spending by 40%? What if a currency collapse hits a key market?"
- SOCIAL: "What if cultural attitudes toward this product shift? What if a generation of users expects something fundamentally different?"
- TECHNOLOGICAL: "What if an AI competitor automates the core value proposition overnight?"
- LEGAL: "What if a class-action lawsuit changes the liability model? What if employment law reclassifies key actors?"
- ENVIRONMENTAL: "What if climate regulation adds cost to every transaction? What if supply chain disruption from extreme weather becomes permanent?"
```

```
FACILITATOR PROMPTS (lateral):
- "What if a competitor drops their price by 50%?"
- "What if the company gets acquired? Or acquires someone else?"
- "What if the market this product serves simply disappears?"
- "What if the system goes viral and needs to serve 100x more users in a market you didn't expect?"
- "What if a key supplier or partner ceases to exist?"
- "What's something that would be catastrophic for the business but that nobody talks about?"
```

### Stressing Technology (Last, Not First)

Only after business concepts, actors, flows, and context have been thoroughly stressed.

```
FACILITATOR PROMPTS:
- "What if the connection between [Component A] and [Component B] is broken?"
- "What if the data store is unavailable for an extended period?"
- "What if a deployment writes incorrect data for an hour before being caught?"
- "What if the identity of a user cannot be verified?"
```

### For Each Stressor — Attractor and Residue

After generating each stressor, immediately explore the attractor and residue:

```
FACILITATOR PROMPTS:
- "This stressor pushes the business into a new state. What does that state look like?"
- "In this new attractor, does our current architecture survive? What breaks?"
- "What's left over — the residue? What changes would we need to make?"
- "How would we detect that this stressor has occurred?"
- "Does this residue overlap with any we've already identified?"
```

### Checking for Criticality

Periodically check whether the architecture is approaching criticality:

```
FACILITATOR PROMPTS:
- "Is this stressor already survived by one of our existing residues?"
- "Are combinations of our existing residues handling this new situation?"
- "Is it getting harder to come up with stressors that aren't already handled?"
- "Let me try a completely different angle — what about [unrelated stressor]?"
```

When looping becomes frequent, the architecture is approaching criticality. Note this and move to contagion analysis.

---

## Phase 4: Contagion Analysis

Build an incidence matrix to understand how stress spreads. This reveals hidden coupling and guides the compression of residues into a coherent architecture.

```
FACILITATOR PROMPTS:
- "Let's build the incidence matrix. Components across the top, stressors down the side."
- "For each cell: does this stressor affect this component? 1 if yes, 0 if no."
- "Where are the row totals highest? These stressors have the widest blast radius."
- "Where are the column totals highest? These components are most vulnerable."
- "Where do we see multiple 1s in the same row? That's hyperliminal coupling — hidden connections only visible under stress."
- "Do any columns have identical or near-identical patterns? Those components might belong together."
- "Are there columns with all zeros? We probably haven't stressed that area enough."
- "What happens if two of these high-impact stressors hit at the same time?"
```

### Seven Triggers to Look For

Walk through each trigger with the participant:

```
FACILITATOR PROMPTS:
1. "HIGH ROW TOTALS — Which stressors affect the most components? These reveal the most dangerous attractors and the deepest coupling."
2. "HIGH COLUMN TOTALS — Which components are hit by the most stressors? These may need to be split or given extra protection."
3. "MULTIPLE 1s IN A ROW — Two components hit by the same stressor means invisible coupling. What's the actual dependency between them?"
4. "SIMILAR COLUMN PATTERNS — Components that respond to stress the same way can often be combined, reducing N."
5. "MANY HIGH NUMBERS — K is too high. The architecture may need fundamental rethinking."
6. "STRESSOR COMBINATIONS — What cascading failures emerge when two stressors happen together?"
7. "ZERO-TOTAL COLUMNS — These components haven't been stressed. They're probably not invulnerable — we just haven't looked hard enough."
```

---

## Phase 5: Integration & Residual Architecture

Compress all residues into a single coherent architecture.

```
FACILITATOR PROMPTS:
- "Looking at all our residues, which changes appear repeatedly? Those are the core architectural shifts."
- "Which residues can be combined without conflict?"
- "Where do residues conflict — requiring different architectural decisions? How do we resolve the trade-off?"
- "Does the integrated architecture make it easy to move between residues as the business shifts?"
- "Let's run FMEA on the critical components — what happens when each one fails?"
- "Looking at stakeholder priorities, are there any residues we should exclude from the first version? (ATAM trade-off)"
- "Describe the residual architecture. How is it different from the naïve architecture?"
```

### Residual Incidence Matrix

After defining the residual architecture, rebuild the incidence matrix with the new components. This provides visual proof that K has been reduced.

```
FACILITATOR PROMPTS:
- "Let's rebuild the matrix with our new components. Same stressors, new columns."
- "What's the new mean vulnerability? Has it dropped from the naïve matrix?"
- "Are there any stressors that still hit more than 60% of new components? Those need more isolation."
- "Compare the two matrices side by side — where did we gain the most isolation?"
```

---

## Phase 6: Empirical Test

Generate a completely new set of stressors — ones never used during the analysis. Test both architectures.

```
FACILITATOR PROMPTS:
- "Let's generate 10-15 new stressors we haven't considered before. Fresh angles only."
- "For each new stressor: does the naïve architecture survive? Does the residual architecture survive?"
- "Tally: how many did the naïve survive (X)? How many did the residual survive (Y)? Total stressors (S)?"
- "Residual Index = (Y - X) / S. Is it positive? That's our evidence of improvement."
- "Are there any new stressors that expose weaknesses we should go back and address?"
- "If Ri is approaching 0 across iterations, the architecture has reached a useful level of criticality."
```

---

## Facilitator Log

Record key facilitation moments in the output artifact. This makes the session reproducible and educational for future participants.

```
WHAT TO RECORD:
- 2-3 example exchanges showing how a stressor was generated (prompt → participant response → attractor/residue)
- Any moments where participants were redirected (e.g., from technical to business stressors)
- Recovery prompts that were used and what they unblocked
- The prompt that triggered the first moment of criticality (looping)
```

---

## Recovery Prompts

Use when the session stalls or participants struggle:

### When stressors are too technical

```
- "Let's step away from infrastructure for a moment. What could change in the market that would break our assumptions?"
- "Forget the code. What could a competitor, regulator, or customer do that we haven't planned for?"
- "Which business concept in our system are we most confident about? That's the one most likely to be wrong."
```

### When participants resist low-probability stressors

```
- "In this method, probability doesn't matter. The mathematical leverage comes from the fact that many different stressors lead to the same attractor."
- "Just because something seems unlikely today doesn't mean it won't happen. The business context is non-ergodic — the future doesn't look like the past."
- "Remember: more projects fail from things nobody expected than from things that were carefully risk-managed."
```

### When participants want to jump to solutions

```
- "Let's stay with the stressor a bit longer. What attractor does it push us toward? What does the business look like in that state?"
- "We'll design solutions during integration. Right now we're trying to see the full landscape of possible futures."
- "The residue is just a note of what would need to change — we don't have to build it yet."
```

### When the session feels overwhelming

```
- "This is normal. The feeling of overwhelm means we're engaging honestly with complexity instead of hiding behind false certainty."
- "Remember, the goal is criticality, not correctness. We don't need to be right about every stressor."
- "Each residue is lightweight — just a description of changes, not a full architectural specification."
```
