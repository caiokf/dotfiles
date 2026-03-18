# Event Model: [System/Feature Name]

**Date:** [Session Date]
**Participants:** [Names/Roles]
**Scope:** [What was modeled]

---

## System Overview

[Brief description of what this system does and its core purpose]

---

## Timeline

> The model flows left to right through time. Each column represents a step in the journey.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           TIME ───────────────────────────────────►          │
├─────────────────────────────────────────────────────────────────────────────┤
│ UI/UX          │ [Screen 1]    │ [Screen 2]    │ [Screen 3]    │           │
│ (White)        │               │               │               │           │
├─────────────────────────────────────────────────────────────────────────────┤
│ Commands       │ [Command 1]   │               │ [Command 2]   │           │
│ (Blue)         │      │        │               │      │        │           │
│                │      ▼        │               │      ▼        │           │
├─────────────────────────────────────────────────────────────────────────────┤
│ Events         │ [Event 1]─────┼──────────────►│ [Event 2]     │           │
│ (Orange)       │      │        │               │      │        │           │
│                │      ▼        │               │      ▼        │           │
├─────────────────────────────────────────────────────────────────────────────┤
│ Read Models    │ [View 1]      │ [View 2]◄─────┼──────┘        │           │
│ (Green)        │               │               │               │           │
├─────────────────────────────────────────────────────────────────────────────┤
│ Automation     │               │ [Processor]   │               │           │
│ (Lilac)        │               │      │        │               │           │
│                │               │      ▼        │               │           │
│                │               │ [Command]     │               │           │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## UI / Wireframes (⬜ White)

### [Screen Name 1]

**Purpose:** [What this screen is for]

**Displays:**
- [Field/data shown]
- [Field/data shown]

**Actions:**
- [Button/action available]
- [Button/action available]

**Read Models Used:** [List of read models]

---

### [Screen Name 2]

**Purpose:** [What this screen is for]

**Displays:**
-

**Actions:**
-

**Read Models Used:**

---

## Commands (🔵 Blue)

### [Command Name 1]

**Triggered by:** [Actor/Screen]

**Payload:**
```json
{
  "field1": "type/description",
  "field2": "type/description"
}
```

**Validation:**
- [Rule 1]
- [Rule 2]

**Produces Events:** [Event names]

---

### [Command Name 2]

**Triggered by:**

**Payload:**
```json
{
}
```

**Validation:**
-

**Produces Events:**

---

## Events (🟧 Orange)

### [Event Name 1]

**Produced by:** [Command name]

**Data:**
```json
{
  "field1": "type/description",
  "field2": "type/description",
  "timestamp": "ISO8601",
  "metadata": {
    "correlationId": "uuid",
    "causationId": "uuid"
  }
}
```

**Consumed by:**
- Read Models: [List]
- Processors: [List]

---

### [Event Name 2]

**Produced by:**

**Data:**
```json
{
}
```

**Consumed by:**
- Read Models:
- Processors:

---

## Read Models (🟢 Green)

### [Read Model Name 1]

**Purpose:** [What query this answers]

**Schema:**
```json
{
  "field1": "type",
  "field2": "type"
}
```

**Built from Events:**
- [Event 1]: [How it updates the read model]
- [Event 2]: [How it updates the read model]

**Used by Screens:** [List of screens]

**Queries Supported:**
- [Query 1]
- [Query 2]

---

### [Read Model Name 2]

**Purpose:**

**Schema:**
```json
{
}
```

**Built from Events:**
-

**Used by Screens:**

---

## Automation / Processors (💜 Lilac)

### [Processor Name 1]

**Triggered by:** [Event name]

**Action:** [What it does]

**Produces:**
- Command: [Command name] OR
- External Call: [What system/API]

**Error Handling:** [What happens on failure]

---

### [Processor Name 2]

**Triggered by:**

**Action:**

**Produces:**

**Error Handling:**

---

## Specifications (Given-When-Then)

### Happy Path: [Scenario Name]

```gherkin
Feature: [Feature Name]

Scenario: [Scenario description]
  Given [precondition/existing state]
    And [another precondition]
  When [command] is executed with:
    | field1 | value1 |
    | field2 | value2 |
  Then [event] is recorded with:
    | field1 | expectedValue1 |
  And [read model] shows:
    | field1 | expectedValue1 |
```

### Alternative Path: [Scenario Name]

```gherkin
Scenario: [Scenario description]
  Given [precondition]
  When [command] is executed
  Then [different event/outcome]
```

### Error Path: [Scenario Name]

```gherkin
Scenario: [Error description]
  Given [precondition]
  When [command] is executed with invalid data
  Then command is rejected with error "[error message]"
  And no events are recorded
```

---

## Aggregate Boundaries

| Aggregate | Commands | Events | Invariants |
|-----------|----------|--------|------------|
| [Name] | [Commands it handles] | [Events it emits] | [Rules it enforces] |
| | | | |

---

## Integration Points

| External System | Direction | Data Exchanged | Protocol |
|-----------------|-----------|----------------|----------|
| [System] | Inbound/Outbound | [What data] | API/Events/etc |
| | | | |

---

## Implementation Notes

### Technical Decisions
-

### Open Questions
-

### Follow-up Tasks
- [ ]
- [ ]

---

## Appendix: Full Event Catalog

| # | Event | Command | Aggregate | Consumers |
|---|-------|---------|-----------|-----------|
| 1 | | | | |
| 2 | | | | |
