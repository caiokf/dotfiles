# Residuality Analysis: [System Name]

**Date:** [Session Date]
**Participants:** [Names/Roles]
**Context:** [Greenfield / Existing System / Post-Incident]

---

## 1. Naïve Architecture

> The simplest architecture that solves the stated problem. No patterns, no frameworks — just the minimum structure.

**Description:**

[Describe the naïve architecture — components, data storage, communication. Keep it simple.]

**Key Assumptions:**

- [List the assumptions baked into this design]
- [These will be challenged by stressors]

---

## 2. Flow Analysis

> Actors and the movement of information between them. Not processes — flows.

### Actors

| Actor        | Type                                 | Role           |
| ------------ | ------------------------------------ | -------------- |
| [Actor name] | Person / Group / Company / Component | [What they do] |
|              |                                      |                |

### Flows

| From      | To        | Data         | Trigger          |
| --------- | --------- | ------------ | ---------------- |
| [Actor A] | [Actor B] | [What moves] | [What causes it] |
|           |           |              |                  |

---

## 3. Stressor Analysis

> Random simulation of the business environment. No probability. All stressors recorded, no matter how unlikely.

| #   | Stressor                                       | Attractor                                      | Survives? | Residue (Changes Needed)                       | Detection                              |
| --- | ---------------------------------------------- | ---------------------------------------------- | --------- | ---------------------------------------------- | -------------------------------------- |
| 1   | [What could happen that we haven't considered] | [What state does this push the business into?] | Yes/No    | [What changes to the architecture are needed?] | [How would we know this is happening?] |
| 2   |                                                |                                                |           |                                                |                                        |
| 3   |                                                |                                                |           |                                                |                                        |
| 4   |                                                |                                                |           |                                                |                                        |
| 5   |                                                |                                                |           |                                                |                                        |

> **Survives is strictly Yes or No.** Document friction, manual workarounds, or partial survival in the Residue column — not as "Yes*" or "Maybe".

### Stressor Sources Explored

- [ ] Concepts and abstractions (Customer, Order, Product — what if they're wrong?)
- [ ] Actors and relationships (roles change, new actors appear)
- [ ] Flows (direction reversal, new flows, volume changes)
- [ ] Business context (competitors, regulation, market shifts, M&A)
- [ ] PESTLE sweep (Political, Economic, Social, Technological, Legal, Environmental)
- [ ] Technology context (component failures, data issues, deployment errors)

### Criticality Indicators

- [ ] New stressors are looping to existing residues
- [ ] Combinations of residues handle novel stressors
- [ ] Difficult to generate stressors not already survived
- Criticality reached after stressor #[___]

---

## 4. Contagion Analysis

> Incidence matrix: how stress spreads through the architecture. Components as columns, stressors as rows. 1 = affected, 0 = not affected.

### Incidence Matrix

|               | [Comp A] | [Comp B] | [Comp C] | [Comp D] | [Comp E] | Row Total |
| ------------- | -------- | -------- | -------- | -------- | -------- | --------- |
| Stressor 1    |          |          |          |          |          |           |
| Stressor 2    |          |          |          |          |          |           |
| Stressor 3    |          |          |          |          |          |           |
| Stressor 4    |          |          |          |          |          |           |
| Stressor 5    |          |          |          |          |          |           |
| **Col Total** |          |          |          |          |          |           |

### Seven Triggers Analysis

| Trigger                    | Finding                                     | Action                      |
| -------------------------- | ------------------------------------------- | --------------------------- |
| 1. High row totals         | [Which stressors have widest impact?]       | [Address coupling]          |
| 2. High column totals      | [Which components most vulnerable?]         | [Split or protect]          |
| 3. Multiple 1s in row      | [Hidden coupling between which components?] | [Decouple or make explicit] |
| 4. Similar column patterns | [Components that respond same way?]         | [Consider combining]        |
| 5. Many high numbers       | [Is K too high overall?]                    | [Rethink architecture]      |
| 6. Stressor combinations   | [Cascading failures?]                       | [Attack trees]              |
| 7. Zero-total columns      | [Unstressed components?]                    | [Generate more stressors]   |

### Hyperliminal Coupling Discovered

| Components          | Coupling                    | Revealed By  | Non-Functional Concern          |
| ------------------- | --------------------------- | ------------ | ------------------------------- |
| [Comp A] ↔ [Comp B] | [Nature of hidden coupling] | [Stressor #] | [Availability/Consistency/etc.] |
|                     |                             |              |                                 |

---

## 5. Residual Architecture

> All residues compressed into a single coherent architecture. The result of integration, FMEA, and ATAM trade-off analysis.

**Description:**

[Describe the residual architecture — how it differs from the naïve architecture, what structural changes were made, and why.]

### Key Architectural Changes from Naïve

| Change         | Driven By Residues  | Rationale                                   |
| -------------- | ------------------- | ------------------------------------------- |
| [What changed] | #[stressor numbers] | [Why this change survives those attractors] |
|                |                     |                                             |

### FMEA Summary

| Component   | Failure Mode   | Effect on System | Detection      | Recovery        |
| ----------- | -------------- | ---------------- | -------------- | --------------- |
| [Component] | [How it fails] | [What happens]   | [How detected] | [How recovered] |
|             |                |                  |                |                 |

### Trade-offs (ATAM)

| Decision    | Option A       | Option B         | Chosen  | Rationale |
| ----------- | -------------- | ---------------- | ------- | --------- |
| [Trade-off] | [One approach] | [Other approach] | [Which] | [Why]     |
|             |                |                  |         |           |

### Residual Incidence Matrix

> Same stressors, new components. Compare with the naïve matrix (Section 4) to verify K reduction.

|               | [New Comp A] | [New Comp B] | [New Comp C] | ... | Row Total |
| ------------- | ------------ | ------------ | ------------ | --- | --------- |
| Stressor 1    |              |              |              |     |           |
| Stressor 2    |              |              |              |     |           |
| **Col Total** |              |              |              |     |           |

**Naïve mean vulnerability:** [___]% | **Residual mean vulnerability:** [___]%

---

## 6. Empirical Test

> New stressors never used during analysis, applied to both architectures. Measures actual improvement.

### Test Stressors

> **Strict binary Yes/No only.** No "Maybe" or partial answers — the Ri calculation requires clean counts.

| #   | Stressor       | Naïve Survives? | Residual Survives? |
| --- | -------------- | --------------- | ------------------ |
| T1  | [New stressor] | Yes/No          | Yes/No             |
| T2  |                |                 |                    |
| T3  |                |                 |                    |
| T4  |                |                 |                    |
| T5  |                |                 |                    |
| T6  |                |                 |                    |
| T7  |                |                 |                    |
| T8  |                |                 |                    |
| T9  |                |                 |                    |
| T10 |                |                 |                    |

### Residual Index

- **X** (naïve survived): [___]
- **Y** (residual survived): [___]
- **S** (total test stressors): [___]
- **Ri = (Y - X) / S = [___]**

| Ri Value | Interpretation                                                      |
| -------- | ------------------------------------------------------------------- |
| Ri > 0   | Positive movement toward criticality                                |
| Ri ≈ 0   | Diminishing returns — architecture has reached useful criticality   |
| Ri < 0   | Residual analysis introduced more problems than it solved — revisit |

---

## 7. Summary & Next Steps

### Heuristics Discovered

- [Key insight about the system's relationship to its context]
- [Abstractions that collapsed and what replaced them]
- [Surprising couplings or attractors discovered]

### Residues Not Yet Implemented

| Residue | Description                  | Value                      | Deferred Because        |
| ------- | ---------------------------- | -------------------------- | ----------------------- |
| [#]     | [What change was identified] | [What it protects against] | [Cost/timing/trade-off] |
|         |                              |                            |                         |

### Recommended Next Steps

| Priority | Action                                | Rationale |
| -------- | ------------------------------------- | --------- |
| 1        | [Most important architectural change] | [Why]     |
| 2        |                                       |           |
| 3        |                                       |           |

### Open Questions

- [Questions that emerged but weren't resolved]
- [Areas that need deeper stressor analysis]
- [Stakeholders who should be consulted]

---

## Facilitator Log

> Key prompts used and example exchanges. Makes the session reproducible and educational.

### Example Exchanges

| Phase | Facilitator Prompt                         | Participant Response (summary)       | Outcome                  |
| ----- | ------------------------------------------ | ------------------------------------ | ------------------------ |
| [#]   | [The prompt that triggered the discovery]  | [What the participant said/realized] | [Stressor/residue found] |
|       |                                            |                                      |                          |

### Redirections & Recovery

- [Moment where participants were redirected, e.g., from technical to business stressors, and what it unblocked]

---

## Session Notes

### Key Insights

-

### Moments of Criticality (Looping)

- Stressor #[___] was already survived by residue from #[___]

### Abstractions That Collapsed

- [Concept] broke when stressed with [stressor] — replaced by [new understanding]
