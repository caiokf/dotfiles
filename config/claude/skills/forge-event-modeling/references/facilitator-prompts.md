# Event Modeling — Facilitator Prompts

Detailed prompts organized by session phase. Use these during facilitation to guide the conversation through each phase.

---

## Phase 1: System Context

```
FACILITATOR PROMPTS:
- "What system or feature are we modeling today?"
- "Do you have events from a previous storming session, or are we starting fresh?"
- "What's the primary user journey we want to model?"
- "Who are the actors — users, admins, external systems?"
- "What are the key business rules that must never be violated?"
- "Are there existing systems this integrates with? What are their constraints?"
- "What compliance or regulatory requirements affect this domain?"
```

Before moving on: "Let me summarize the context. Does this capture the scope correctly?"

---

## Phase 2: UI Screens & Data Requirements

Start with the white boxes at the top — what does the user see?

```
FACILITATOR PROMPTS:
- "Let's start with the user interface. What's the first screen or interaction?"
- "What information does the user see on this screen?"
- "What actions can they take from here?"
- "What feedback does the user receive after taking action?"
- "Are there different views for different user roles?"
- "What validation rules apply to each field? What makes input invalid?"
- "What does the user see when there's no data yet? (empty states)"
- "What error messages appear when validation fails?"
```

Capture as: `[Screen Name]` — key fields (with type, required, validation), actions visible

Before moving on: "We've identified [N] screens. Let me list them — does this cover the user journey?"

---

## Phase 3: Commands — Blue Boxes

```
FACILITATOR PROMPTS:
- "What command does the user invoke from [Screen]?"
- "What data does this command carry? What's the payload?"
- "What preconditions must be true for this command to succeed?"
- "What happens when each precondition fails? What's the rejection event?"
- "Who is authorized to execute this command? Any ownership checks?"
- "What's the command's name in ubiquitous language?"
- "What happens if this command is sent twice accidentally? Is it idempotent?"
- "Can this command partially succeed? What happens to the successful parts?"
```

Format:

```
Command: [CommandName]
Payload: { field1, field2, ... }
Actor: [who triggers it]
Authorization: [role/permission required]
Idempotency: [strategy]
```

Before moving on: "We have [N] commands. Every command should produce at least one event — let's verify."

---

## Phase 4: Events — Orange Boxes

```
FACILITATOR PROMPTS:
- "What event is recorded when [Command] succeeds?"
- "What data does this event capture? What's the minimum needed for audit/replay?"
- "Can this command result in different events based on conditions?"
- "What's the event's name — remember, past tense?"
- "What failure events need to be recorded for audit, analytics, or triggering compensating actions?"
- "How will this event evolve over time? What fields might be added?"
- "Does the order of these events matter? What happens if they arrive out of order?"
- "What metadata should every event carry? (correlationId, timestamp, actor)"
```

Format:

```
Event: [EventName]
Data: { field1, field2, timestamp, ... }
Triggered by: [Command]
Version: [current version, evolution notes]
```

Before moving on: "We have [N] events. Every event should feed a read model or trigger an automation — let's check."

---

## Phase 5: Read Models — Green Boxes

```
FACILITATOR PROMPTS:
- "What data does [Screen] need to display?"
- "Which events contribute to building this read model?"
- "Is this a list view, detail view, or aggregate/summary?"
- "How fresh does this data need to be?"
  - Real-time (< 2s) — for active workflows
  - Near real-time (< 30s) — for dashboards
  - Eventually consistent (< 5min) — for analytics
  - Cached with TTL — for catalogs/reference data
- "What queries will users perform against this data?"
- "Who can see this data? Any row-level or field-level security?"
- "How large could this dataset grow? Pagination or filtering needed?"
```

Format:

```
Read Model: [Name]
Fields: { field1, field2, ... }
Built from: [Event1, Event2, ...]
Used by: [Screen]
Freshness: [requirement]
Access: [who can query]
```

---

## Phase 6: Automation & Policies — Lilac Swimlane

```
FACILITATOR PROMPTS:
- "When [Event] happens, what must always happen? What should usually happen?"
- "Are there notifications, emails, or webhooks to send?"
- "Do any events trigger commands in other parts of the system?"
- "Are there scheduled jobs or time-based triggers?"
- "What external systems need to be notified?"
- "What happens if the automated action fails? Retry? Dead letter? Alert?"
- "Can multiple policies trigger from the same event? What's the priority?"
- "When should automation escalate to a human? What's the escalation path?"
```

Format:

```
When [Event] → [Processor] → [Command/Action]
On failure: [retry strategy or escalation]
```

---

## Phase 7: Timeline Organization

```
FACILITATOR PROMPTS:
- "Let's walk through the timeline from start to finish."
- "What are the lifecycle phases? (e.g., acquisition, trial, active, churned)"
- "Is this the order things happen, or can some occur in parallel?"
- "Where are the aggregate boundaries? What events belong together?"
- "Which workflows span multiple aggregates and need saga coordination?"
- "What compensating actions are needed if a step in a multi-step process fails?"
- "Are there any gaps — commands without events, or events without readers?"
```

Validation check: "Every command produces event(s), every event feeds a read model or automation."

---

## Phase 8: Given-When-Then Specifications

```
FACILITATOR PROMPTS:
- "Let's write a specification for the happy path."
- "Given the system is in [state], when [command] happens, then [events] are recorded."
- "What are the key alternative scenarios?"
- "What are the top 5 most likely ways this could fail in production?"
- "What happens at the boundaries? (exactly at quota limit, last day of trial, $0 invoice)"
- "What happens during partial system outage? (payment gateway down, DB read-only)"
- "What malicious inputs should we guard against?"
```

Format:

```gherkin
Given [preconditions/existing events]
When [command is executed]
Then [events are recorded]
And [read model reflects changes]
```

---

## Phase 9: Synthesis

```
FACILITATOR PROMPTS:
- "Let me compile the complete event model. Does this look right?"
- "Let's quantify: [N] screens, [N] commands, [N] events, [N] read models, [N] automations, [N] specifications."
- "Are there any gaps or areas we should revisit?"
- "What are the riskiest or most complex parts of this model?"
- "What implementation tasks fall out of this? What should be built first?"
```
