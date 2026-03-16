---
description: Run adversarial security analysis against a service
argument-hint: <service name, e.g. "platform.api-keys">
---

Run an adversarial red team exercise against the specified service, finding exploit paths, business logic abuse, and privilege escalation vectors.

## Input

- `$ARGUMENTS`: service/app/package name when applicable (e.g., `platform.api-keys`, `platform.payments`)
- If empty, use AskUserQuestion to ask which service/app/package to target or if targetting the whole repo

## Process

### 1. Reconnaissance

Read the service to build an attack surface map:

1. **Routes & endpoints** — read route handlers, identify all HTTP methods and paths
2. **Auth configuration** — read Cerbos policies (YAML), Auth0 Resource Server scopes from Pulumi infra
3. **Middleware stack** — what guards are applied? (auth, rate limiting, idempotency, mode validation)
4. **Data access** — what database schemas/tables does it touch? What events does it emit/consume?
5. **External dependencies** — what other services does it call? What APIs does it consume?
6. **Input validation** — are request bodies validated with Zod schemas? Are URL params validated?
7. **Test/live mode boundaries** — how does it handle `X-SlicePay-Mode` header?

### 2. Threat analysis (parallel agents)

Spawn 3 adversarial sub-agents in parallel:

**Agent 1 — Auth & Access Control (`security-expert`)**
- Can a user with Role A access resources belonging to Role B? (IDOR, broken access control)
- Are there endpoints missing auth middleware entirely?
- Can API key scopes be escalated?
- Is test mode API key accepted where only live mode should work?
- Are Cerbos policies consistent with Auth0 scope definitions?

**Agent 2 — Business Logic Abuse (`engineer`)**
- Can payment flows be manipulated? (double-spend, negative amounts, timing attacks)
- Can lay-by plans be gamed? (cancel after benefit, replay attacks)
- Are there race conditions in event handlers or projections?
- Can idempotency keys be reused maliciously?
- Can a merchant see another merchant's data?

**Agent 3 — Input & Injection (`security-expert`)**
- SQL injection vectors (even with ORM — raw queries, dynamic WHERE)
- Event payload injection (can a crafted event corrupt projections?)
- Header injection (X-SlicePay-Mode spoofing, host header attacks)
- Path traversal in any file-handling code
- Prototype pollution, ReDoS in validation patterns
- Are error messages leaking internal state?

### 3. Validate findings

Spawn an `oracle` sub-agent to review all findings and filter:
- **Confirmed** — the code clearly allows this attack
- **Likely** — the code appears vulnerable but needs runtime verification
- **Theoretical** — possible in theory but mitigated by other controls
- **False positive** — the finding is incorrect given the actual code

### 4. Output report

```markdown
# Red Team Report: <service-name>

**Date:** <date>
**Commit:** <commit hash>
**Attack surface:** <N routes, M events, P policies>

## Critical Findings (immediate action required)

### [CRIT-1] <title>
- **Vector:** <how the attack works>
- **Impact:** <what an attacker gains>
- **Evidence:** `<file:line>` — <code snippet showing the vulnerability>
- **Remediation:** <specific fix>

## High Findings

### [HIGH-1] <title>
<same structure>

## Medium Findings
<same structure>

## Low / Informational
<bullet list>

## Attack Surface Summary

| Area | Coverage | Notes |
|---|---|---|
| Auth middleware | X/Y endpoints covered | <gaps> |
| Cerbos policies | X/Y resources covered | <gaps> |
| Input validation | X/Y endpoints validated | <gaps> |
| Mode isolation | <status> | <issues> |

## Positive Observations
<security controls that are working well>
```

Save the report to `.personal/red-team/<service-name>-<date>.md`.

## Constraints

- This is a READ-ONLY exercise — never modify code, never make requests to live services
- Never attempt actual exploitation — analysis only
- Focus on findings that are specific and actionable, not generic OWASP checklists
- If a finding requires runtime verification, note it as "Likely" and describe how to verify
- Always check for the existence of mitigating controls before flagging a vulnerability
