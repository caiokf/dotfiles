# Event Storming Board: [System/Domain Name]

**Date:** [Session Date]
**Participants:** [Names/Roles]
**Scope:** [What was explored]

---

## Timeline

> Events flow left to right, representing time. Parallel swimlanes show concurrent processes.

### Phase 1: [Phase Name]

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│  👤 [Actor]                                                                 │
│     │                                                                       │
│     ▼                                                                       │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐         │
│  │ 📘 [Command]    │───►│ 🟧 [Event]      │───►│ 🟧 [Event]      │         │
│  └─────────────────┘    └─────────────────┘    └─────────────────┘         │
│                                │                                            │
│                                ▼                                            │
│                         ┌─────────────────┐                                │
│                         │ 💜 [Policy]     │                                │
│                         │ When X then Y   │                                │
│                         └─────────────────┘                                │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Phase 2: [Phase Name]

```
[Continue timeline...]
```

---

## Domain Events (🟧 Orange)

| Event | Description | Triggered By | Aggregate |
|-------|-------------|--------------|-----------|
| [Event Name] | [What happened] | [Command/Policy] | [Aggregate] |
| | | | |

---

## Commands (📘 Blue)

| Command | Description | Actor | Resulting Events |
|---------|-------------|-------|------------------|
| [Command Name] | [What it does] | [Who triggers] | [Events produced] |
| | | | |

---

## Actors (👤 Yellow)

| Actor | Role | Commands They Trigger |
|-------|------|----------------------|
| [Actor Name] | [Their role] | [List of commands] |
| | | |

---

## Aggregates (📙 Yellow Rectangle)

| Aggregate | Responsibilities | Commands Handled | Events Emitted |
|-----------|-----------------|------------------|----------------|
| [Aggregate Name] | [What it enforces] | [Commands] | [Events] |
| | | | |

---

## Policies (💜 Lilac)

| Policy | Trigger Event | Resulting Action |
|--------|---------------|------------------|
| When [Event] | Then [Action/Command] | [Effect] |
| | | |

---

## External Systems (🟩 Green)

| System | Interaction | Events Sent/Received |
|--------|-------------|---------------------|
| [System Name] | [How we interact] | [Events] |
| | | |

---

## Hotspots (🔴 Red/Pink)

> Areas of confusion, conflict, or opportunity identified during the session.

| Hotspot | Description | Priority |
|---------|-------------|----------|
| [Issue] | [Details] | High/Medium/Low |
| | | |

---

## Ubiquitous Language

| Term | Definition |
|------|------------|
| [Domain Term] | [Precise definition as used in this domain] |
| | |

---

## Insights & Observations

### Key Discoveries
-

### Surprises
-

### Open Questions
-

---

## Follow-Up Actions

| Action | Owner | Priority |
|--------|-------|----------|
| | | |

---

## Recommended Next Steps

- [ ] Deep dive into [aggregate/area] with `/event-storming`
- [ ] Design system with `/event-modeling`
- [ ] Map bounded contexts with `/bounded-contexts`
- [ ] Analyze resilience with `/residuality`
