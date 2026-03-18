# Context Map: [Domain Name]

**Date:** [Session Date]
**Participants:** [Names/Roles]
**Scope:** [What was mapped]

---

## Domain Overview

[High-level description of the overall domain and business area]

---

## Context Map Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│                              [DOMAIN NAME]                                  │
│                                                                             │
│   ┌───────────────────┐                       ┌───────────────────┐        │
│   │                   │      Partnership      │                   │        │
│   │   [Context A]     │◄─────────────────────►│   [Context B]     │        │
│   │   ★ Core          │                       │   ○ Supporting    │        │
│   │                   │                       │                   │        │
│   │   Team: [Name]    │                       │   Team: [Name]    │        │
│   └───────────────────┘                       └───────────────────┘        │
│            │                                           ▲                    │
│            │ Customer─Supplier                         │                    │
│            │ (downstream)                              │ Conformist         │
│            ▼                                           │                    │
│   ┌───────────────────┐                       ┌───────────────────┐        │
│   │                   │    Anti-Corruption    │                   │        │
│   │   [Context C]     │─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│   [Context D]     │        │
│   │   ○ Supporting    │        Layer          │   □ Generic       │        │
│   │                   │         (ACL)         │                   │        │
│   │   Team: [Name]    │                       │   Team: [Name]    │        │
│   └───────────────────┘                       └───────────────────┘        │
│                                                                             │
│   Legend:  ★ Core Domain   ○ Supporting   □ Generic                        │
│            ──► Upstream to Downstream                                       │
│            ◄─► Partnership (mutual)                                         │
│            ─ ─ Anti-Corruption Layer                                        │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

External Systems:
┌───────────────────┐       ┌───────────────────┐
│   [External 1]    │       │   [External 2]    │
│   Open Host Svc   │       │   Published Lang  │
└───────────────────┘       └───────────────────┘
```

---

## Bounded Contexts

### [Context Name 1]

**Classification:** Core Domain / Supporting Subdomain / Generic Subdomain

**Team:** [Team name]

**Core Responsibility:**
[What this context owns and decides]

**Key Concepts:**
| Concept | Definition in This Context |
|---------|---------------------------|
| [Term] | [What it means here] |
| | |

**Aggregates:**
- [Aggregate 1]: [Responsibility]
- [Aggregate 2]: [Responsibility]

**Key Behaviors:**
- [Capability 1]
- [Capability 2]

**Does NOT handle:**
- [Out of scope item]
- [Out of scope item]

---

### [Context Name 2]

**Classification:**

**Team:**

**Core Responsibility:**

**Key Concepts:**
| Concept | Definition in This Context |
|---------|---------------------------|
| | |

**Aggregates:**
-

**Key Behaviors:**
-

**Does NOT handle:**
-

---

### [Context Name 3]

**Classification:**

**Team:**

**Core Responsibility:**

**Key Concepts:**
| Concept | Definition in This Context |
|---------|---------------------------|
| | |

**Aggregates:**
-

**Key Behaviors:**
-

**Does NOT handle:**
-

---

## Context Relationships

### [Context A] ↔ [Context B]

**Relationship Pattern:** Partnership / Customer-Supplier / Conformist / ACL / Shared Kernel / Open Host / Published Language / Separate Ways

**Direction:** [A] upstream → [B] downstream / Mutual / N/A

**Description:**
[How these contexts interact and why]

**Integration Mechanism:** API / Events / Shared Database / File Transfer

**Data Exchanged:**
| From | To | Data | Frequency |
|------|-----|------|-----------|
| [A] | [B] | [What] | [How often] |
| | | | |

**Contract:**
```
[API endpoint, event schema, or interface description]
```

**Change Management:**
[How changes are coordinated between teams]

---

### [Context C] ↔ [Context D]

**Relationship Pattern:**

**Direction:**

**Description:**

**Integration Mechanism:**

**Data Exchanged:**
| From | To | Data | Frequency |
|------|-----|------|-----------|
| | | | |

**Contract:**
```
```

**Change Management:**

---

## Language Variations

> Same terms that mean different things in different contexts

| Term | [Context A] | [Context B] | [Context C] |
|------|-------------|-------------|-------------|
| Customer | [Definition] | [Definition] | [Definition] |
| Order | | | |
| Account | | | |
| | | | |

---

## Translation Maps

### [Context A] → [Context B] Translation

| Context A Term | Context B Term | Notes |
|----------------|----------------|-------|
| [Term] | [Equivalent] | [Any nuance] |
| | | |

### [Context B] → [Context C] Translation

| Context B Term | Context C Term | Notes |
|----------------|----------------|-------|
| | | |

---

## Anti-Corruption Layers

### ACL: [Context X] protecting from [Context Y]

**Purpose:** [Why this ACL exists]

**Location:** [Where the ACL lives - in X or as separate service]

**Translations:**

| External (Y) | Internal (X) | Transformation |
|--------------|--------------|----------------|
| [Their term/structure] | [Our term/structure] | [How we convert] |
| | | |

**Validation Rules:**
- [What we verify/reject from external context]

---

## Team Topology Alignment

| Context | Team | Team Type | Interaction Mode |
|---------|------|-----------|------------------|
| [Context] | [Team name] | Stream-aligned / Platform / Enabling / Complicated-subsystem | [How they work with others] |
| | | | |

### Alignment Issues

| Issue | Impact | Recommendation |
|-------|--------|----------------|
| [Misalignment description] | [What problems it causes] | [How to fix] |
| | | |

---

## Integration Specifications

### Synchronous APIs

| Provider | Consumer | Endpoint | Purpose |
|----------|----------|----------|---------|
| [Context] | [Context] | [/path] | [What it does] |
| | | | |

### Asynchronous Events

| Publisher | Event | Subscribers | Purpose |
|-----------|-------|-------------|---------|
| [Context] | [EventName] | [Contexts] | [What it signals] |
| | | | |

### Shared Resources (Anti-pattern - Document for Migration)

| Resource | Contexts Sharing | Migration Plan |
|----------|------------------|----------------|
| [Database/Table] | [Contexts] | [How to separate] |
| | | |

---

## Recommendations

### Boundary Changes

| Current State | Recommended Change | Rationale |
|---------------|-------------------|-----------|
| [What exists] | [What to change] | [Why] |
| | | |

### New Contexts to Extract

| Source Context | New Context | Concepts to Move |
|----------------|-------------|------------------|
| [Current] | [Proposed] | [What belongs there] |
| | | |

### Integration Improvements

| Current | Recommended | Benefit |
|---------|-------------|---------|
| [Current approach] | [Better approach] | [Why it's better] |
| | | |

---

## Migration Path

### Phase 1: [Description]
- [ ] [Task]
- [ ] [Task]

### Phase 2: [Description]
- [ ] [Task]
- [ ] [Task]

### Phase 3: [Description]
- [ ] [Task]
- [ ] [Task]

---

## Session Notes

### Key Insights
-

### Contested Boundaries
-

### Open Questions
-

### Follow-up Sessions
- [ ] Deep dive on [context]
- [ ] Alignment discussion with [team]
