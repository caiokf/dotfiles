# Event Storming — Facilitator Prompts

Detailed prompts organized by session phase. Use these during facilitation to guide the conversation through each phase.

---

## Phase 1: Set the Stage

```
OPENING:
"In Event Storming, we value quantity over quality in the early phases.
There are no wrong events — if you think something might be relevant,
throw it on the board. We'll organize later."

FACILITATOR PROMPTS:
- "What system or business process are we going to storm today?"
- "Can you give me a 2-3 sentence description of what this system does?"
- "Who are the main actors or users involved in this process?"
- "What level of depth do we need?"
  - Big Picture: Exploring an entire value stream end-to-end
  - Process Level: Deep dive into one bounded context or process
  - Design Level: Detailed enough to start implementation (invariants, state machines)
```

---

## Phase 2: Chaotic Exploration — Domain Events

Discover domain events using the orange sticky note format. Events are past-tense facts that happened in the domain.

```
FACILITATOR PROMPTS:
- "Let's start throwing events on the board. What's the first thing that happens?"
- "What happens after [previous event]? What's the next significant thing?"
- "What's the happy path? And what can go wrong?"
- "What events would a domain expert care about? What would they want to be notified of?"
- "Is there anything that happens periodically, on a schedule, or with a deadline?"
- "Are there any time limits or SLAs that trigger events if exceeded?"

EXCEPTION & COMPENSATION PROMPTS:
- "For each happy path event — what's the 'undo' or failure event?"
- "What happens when [Event] fails partially or times out?"
- "How do you recover from a failure at this step?"
- "When something goes wrong, who gets notified?"
```

Format events as: `[Event Name]` — past tense, business language
Examples: `Order Placed`, `Payment Received`, `Shipment Dispatched`, `Refund Issued`

```
IF STUCK:
- "What happens at the very end of this process? Let's work backwards."
- "What's the one event that absolutely must happen for success?"
- "What would make a stakeholder call you at 2am about this system?"
```

**TRANSITION:** "Great — we've got a lot on the board! Now let's shift from brainstorming to organizing. This might feel slower, but it helps us see the full picture."

---

## Phase 3: Enforce Timeline

Organize events into a coherent timeline from left to right.

```
FACILITATOR PROMPTS:
- "Let's arrange these events in order. What happens first?"
- "I see we have [Event A] and [Event B] — which comes first?"
- "Are there events that can happen in any order, or is there a strict sequence?"
- "Where are the swimlanes? Are there parallel processes happening?"
- "Which events MUST complete before the next can start?"
```

---

## Phase 4: Commands, Actors & External Systems

Add blue sticky notes for commands, yellow for actors, and green for external systems.

```
FACILITATOR PROMPTS:
- "What command or action causes [Event] to happen?"
- "Who or what triggers this command? Is it a user, system, or external service?"
- "What information does the actor need to provide to execute this command?"
- "Are there any automated triggers — time-based, event-based, or external webhooks?"

EXTERNAL SYSTEMS PROMPTS:
- "Which events come FROM systems outside our domain?"
- "Which events do we need to SEND to external systems?"
- "What third-party services are involved — payments, notifications, shipping?"
- "What happens if an external system is unavailable?"
```

Format: `Actor` performs `Command` → results in `Event`

```
IF STUCK:
- "Let's pick a specific event. If you were a user, what button would you click?"
- "Is this triggered by a human decision or automatically by the system?"
```

---

## Phase 5: Read Models & Views

Add green sticky notes for read models — the information actors need to see.

```
FACILITATOR PROMPTS:
- "Before performing [Command], what information does the actor need to see?"
- "What would be displayed on the screen for this step?"
- "Are there dashboards, lists, or reports that users check regularly?"
- "What search or filter capabilities do users need?"
- "Is this view built from events in one aggregate or multiple?"
```

Format: `[View Name]` shows `[Data Elements]` to help `[Actor]` decide `[Command]`

---

## Phase 6: Aggregates & Boundaries

Identify aggregates (yellow rectangles) that handle commands and emit events.

```
FACILITATOR PROMPTS:
- "What entity is responsible for handling [Command] and ensuring [Event] happens correctly?"
- "What data does this aggregate need to make its decision?"
- "What invariants or business rules must this aggregate enforce?"
- "Do these events belong to the same aggregate, or are they separate concerns?"
- "What MUST be true before [Command] can be accepted?"
```

```
IF STUCK:
- "If you had to give this cluster of events a name, what would you call the 'thing' that manages them?"
- "What noun would a domain expert use to describe this?"
```

---

## Phase 7: Bounded Contexts

Identify natural boundaries where language or ownership changes.

```
FACILITATOR PROMPTS:
- "Where do you see language changing? Same concept, different words?"
- "Which aggregates always change together vs independently?"
- "Where would you draw a line to split teams or services?"
- "What data crosses from one area to another — and who owns the truth?"
- "Are there places where one area waits for or depends on another?"
```

Context relationship patterns to identify:

- **Upstream/Downstream**: Who publishes events the other consumes?
- **Shared Kernel**: What's genuinely shared between contexts?
- **Anti-Corruption Layer**: Where do we translate between languages?

---

## Phase 8: Policies & Reactions

Add lilac sticky notes for policies — automated reactions to events.

```
FACILITATOR PROMPTS:
- "When [Event] happens, does anything else need to happen automatically?"
- "Are there any business rules like 'whenever X, then Y'?"
- "What notifications or side effects are triggered by this event?"
- "Are there any compliance or regulatory actions that must follow?"
- "If this event happened at 3am with no humans watching, what needs to happen automatically?"
```

Format: `When [Event] then [Action]`

---

## Phase 9: Hotspots & Questions

Mark areas of confusion, conflict, or opportunity with pink/red stickies.

```
FACILITATOR PROMPTS:
- "What parts of this flow are unclear or contentious?"
- "Where do you see potential problems or bottlenecks?"
- "What questions came up that we couldn't answer?"
- "What would you want to dig deeper into?"
```

---

## Phase 10: Synthesis

Wrap up and produce the artifact.

```
FACILITATOR PROMPTS:
- "Let me summarize what we discovered. As you review it, tell me what's wrong or missing."
- "On a scale of 1-10, how well does this capture your mental model? What would make it a 10?"
- "What are the top 3 insights or surprises from this session?"
- "What should we explore in a follow-up session?"
```
