# Bounded Context Mapping — Facilitator Prompts

Detailed prompts organized by session phase. Use these during facilitation to guide the conversation through each phase.

---

## Phase 1: Set the Stage

```
FACILITATOR PROMPTS:
- "What's the overall domain or system we're mapping?"
- "Is this an existing system we're analyzing or a new design?"
- "What teams or groups are involved in this domain?"
- "Are there existing service boundaries or is it a monolith?"

FOR LARGE DOMAINS (>6-8 potential contexts):
- "This is a large domain. Let's identify major clusters first."
- "Which area is most urgent or causing the most pain?"
- "We may need multiple sessions — let's focus on [priority area] today."
```

---

## Phase 2: Domain Exploration

```
FACILITATOR PROMPTS:
- "What are the major business capabilities in this domain?"
- "Walk me through the core workflows — what are the main things users do?"
- "What are the key nouns — the entities and concepts people talk about?"
- "Are there different meanings for the same word in different areas?"
- "Where do you see natural clustering of concepts and behaviors?"

FOR EXISTING SYSTEMS (Brownfield):
- "Where are the natural seams in the current codebase?"
- "Are there implicit boundaries already forming — modules that don't talk to each other?"
- "What shared databases or tables span multiple concerns today?"
- "Where is the 'big ball of mud' — tightly coupled areas that are painful to change?"

DEPTH PROMPTS (when answers are surface-level):
- "You mentioned [capability]. What makes that hard? Where does it get complicated?"
- "What rules or policies govern [behavior]? Who enforces them?"
- "When things go wrong with [process], how do you fix it?"
```

---

## Phase 3: Linguistic Boundaries

```
FACILITATOR PROMPTS:
- "You mentioned [Term] — does that mean the same thing everywhere?"
- "When Sales says 'Customer' and Support says 'Customer' — same thing?"
- "Where do you see translation happening between teams or areas?"
- "What terms are contested or confusing across the organization?"
- "Are there concepts that exist in one area but not another?"
```

Document language variations:

| Term     | Context A Meaning | Context B Meaning    |
| -------- | ----------------- | -------------------- |
| Customer | Person who buys   | Account with tickets |
| Order    | Purchase intent   | Fulfillment request  |

---

## Phase 4: Context Identification

```
FACILITATOR PROMPTS:
- "Based on the language differences, what bounded contexts emerge?"
- "What name captures the essence of this context?"
- "What's the core responsibility of this context?"
- "What concepts live inside this boundary?"
- "What does this context NOT care about?"

IS THIS CURRENT OR TARGET STATE?
- "Is this boundary how things work today, or how you want them to work?"
```

For each context, capture:

- **Name**: Clear, business-meaningful name
- **Core Domain Concepts**: The entities and value objects inside
- **Responsibilities**: What this context owns and decides
- **Team Ownership**: Who builds and maintains this

---

## Phase 5: Boundary Rationale

```
FACILITATOR PROMPTS:
- "Beyond language differences, why should [Context A] be separate from [Context B]?"
- "What would break if we merged these two contexts?"
- "Does this context need to scale, deploy, or change independently?"
- "Are there security, compliance, or data privacy reasons for this boundary?"
- "Is this boundary serving the business or just reflecting historical accidents?"

DOCUMENT THE FORCES:
- Independence drivers: What needs to vary independently?
- Compliance factors: Regulatory or security constraints
- Operational needs: Scaling, availability, deployment frequency
- Organizational factors: Team autonomy, vendor boundaries
```

---

## Phase 6: Context Classification

```
FACILITATOR PROMPTS:
- "Is [Context] core to your competitive advantage, or supporting?"
- "Would you build this in-house or could you buy/outsource it?"
- "Where should you invest the most design effort?"
- "Which contexts are legacy that you'd like to eventually replace?"
```

---

## Phase 7: Data Ownership

```
FACILITATOR PROMPTS:
- "For [Entity], which context is the source of truth?"
- "Who creates this data? Who can modify it? Who just reads it?"
- "If this data needs to change, where does the change originate?"
- "Are there entities that are co-owned today? How do you resolve conflicts?"
- "Where do you have data duplication, and is it intentional?"
```

Create a data ownership summary:

| Entity   | Source of Truth | Writers  | Readers           |
| -------- | --------------- | -------- | ----------------- |
| Customer | Identity        | Identity | Orders, Support   |
| Order    | Orders          | Orders   | Shipping, Billing |

---

## Phase 8: Relationship Mapping

```
FACILITATOR PROMPTS:
- "How does [Context A] interact with [Context B]?"
- "Who's upstream and who's downstream in this relationship?"
- "When [Context A] changes, does [Context B] have to change too?"
- "Is there a power dynamic — who dictates the interface?"
- "How do these teams collaborate in practice?"

FOR EACH RELATIONSHIP:
- "What pattern best describes the [A]-[B] relationship?"
- "What's the integration mechanism — API, events, shared database?"
- "What contract exists between these contexts?"
- "What happens when the upstream context is unavailable?"
```

---

## Phase 9: External Systems

```
FACILITATOR PROMPTS:
- "What external systems, APIs, or third-party services do you integrate with?"
- "For each external system, which internal context owns that integration?"
- "What happens when [External System] is down or changes its API?"
- "Are there industry standards (Published Language) you must conform to?"
- "Where do you need Anti-Corruption Layers to insulate from external changes?"
```

---

## Phase 10: Event Flows

```
FACILITATOR PROMPTS:
- "What significant business events occur in [Context]?"
- "When [Event] happens, who needs to know? What do they do with it?"
- "Are there event chains — one event triggering another?"
- "What ordering constraints exist between events?"
- "What happens if an event is lost or processed out of order?"
```

---

## Phase 11: Team Alignment

```
FACILITATOR PROMPTS:
- "Which team owns [Context]?"
- "Are there contexts that span multiple teams? Is that intentional?"
- "Does the team structure match the context boundaries?"
- "Where do you see coordination overhead between teams?"
- "Would different boundaries reduce cross-team dependencies?"
```

---

## Phase 12: Boundary Validation

```
FACILITATOR PROMPTS:
- "Let's test these boundaries. Walk me through [concrete scenario]."
- "A customer places an order, requests a refund, then disputes. How does each context participate?"
- "Which context handles [edge case]? Is that clear or ambiguous?"
- "If these boundaries existed, what question would still be unclear?"
```

---

## Phase 13: Synthesis

```
FACILITATOR PROMPTS:
- "Let me compile the context map. Does this capture the landscape?"
- "What boundary changes or migrations are needed?"
- "What integration work is highest priority?"
- "What's the first step — what can we do this quarter?"
```
