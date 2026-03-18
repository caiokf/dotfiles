---
description: Use when creating or updating third-party vendor documentation for SOC 2 compliance — enforces the standard template and frontmatter schema. Handles both new vendor creation and updates. Triggers on "vendor doc", "SOC 2 vendor", "third-party documentation", "new vendor".
---

# Writing Vendor Documentation

## Overview

Write third-party vendor documentation files for SOC 2 compliance. Each vendor gets one Markdown file in `docs/vendors/` with YAML frontmatter and six fixed sections. Keep files concise and scannable — this is a risk register entry, not a security assessment report.

## When to Use

- Adding a new third-party vendor (SaaS, cloud infrastructure, consultant, external party with system/data access)
- Updating an existing vendor file after a review or incident
- Responding to a SOC 2 audit finding about vendor management (TSC C1.2, CC9.2)

## Template

Every vendor file MUST use this exact structure. Do not add, remove, rename, or reorder sections.

```markdown
---
vendor: <Vendor Name>
website: <https://vendor.com>
category: <SaaS | Cloud Infrastructure | Consultant | Payment Processor | Other>
status: <active | under-review | deprecated>
last-reviewed: <YYYY-MM-DD>
next-review: <YYYY-MM-DD>
review-cadence: <6 months | 12 months>
risk-tier: <critical | high | moderate | low>
residual-risk: <critical | high | moderate | low | unknown>
---

# <Vendor Name>

## Overview

What the vendor does and why SlicePay uses it. 1-3 sentences max.

## Data Classification

- **Data transmitted**: What data flows to this vendor
- **Data sensitivity**: PII / financial / source code / none
- **Data residency**: Where data is stored/processed
- **Retention**: Vendor's data retention policy
- **Training opt-out**: Whether data is used for model training (AI vendors only)

## Security & Compliance

- **SOC 2 report available**: Yes (Type I/II, date) / No / Unknown
- **DPA in place**: Yes (date) / No
- **Vendor security review completed**: Yes (date) / No
- **Encryption in transit**: Yes/No
- **Encryption at rest**: Yes/No

## Access & Integration

- **Integration method**: API / SDK / SaaS UI / CI pipeline / etc.
- **Authentication**: How we authenticate (API key, OAuth, SSO, etc.)
- **Access scope**: What the vendor can access in our systems
- **Who has admin access**: Roles or individuals with admin access

## Business Continuity

- **Criticality**: High/Medium/Low — what breaks if this vendor goes down
- **Alternatives evaluated**: Brief note on alternatives considered
- **Exit strategy**: How we would migrate away if needed

## Action Items

- [ ] Outstanding remediation items as checkboxes
- [ ] Each item should be a concrete, actionable task
```

## Frontmatter Rules

- **Flat key-value pairs only.** No nested objects, no arrays, no YAML anchors.
- **`risk-tier`** is the inherent risk before controls. Base it on: data sensitivity, access scope, and business criticality.
- **`residual-risk`** is the risk after security controls and reviews are applied. Set to `unknown` until a vendor security review is completed.
- **`review-cadence`** — use `6 months` for critical/high risk-tier, `12 months` for moderate/low.
- **`next-review`** — calculate from `last-reviewed` + `review-cadence`.
- **`category`** — pick the closest match. Use `Other` only if none fit.

## Risk Tier Guidelines

| Tier     | Criteria                                                                                |
| -------- | --------------------------------------------------------------------------------------- |
| critical | Processes financial transactions, stores PII, or has write access to production systems |
| high     | Accesses source code, CI/CD pipelines, or internal business logic                       |
| moderate | Has limited data access, no production system interaction                               |
| low      | No data access, purely informational or development tooling                             |

## Section Rules

- **Six sections exactly.** Do not add sections for configuration standards, approval signatures, subprocessors, privacy, financial terms, incident response playbooks, or logging requirements. Those belong in separate processes, not in the vendor file.
- **Bullet format** — `**Label**: description` using colon, not em dash.
- **Overview** — 1-3 sentences. Not a marketing description. State what we use it for.
- **Data Classification** — include `Training opt-out` only for AI/ML vendors. Omit for others.
- **Action Items** — must be present even if empty (use `None` if fully remediated). Every item must be a checkbox `- [ ]` with a concrete task, not a vague concern.

## File Naming

- One file per vendor: `docs/vendors/<vendor-slug>.md`
- Slug format: lowercase, hyphens, no spaces (e.g., `factory-ai.md`, `amazon-web-services.md`, `github.md`)

## Common Mistakes

| Mistake                                      | Fix                                                                           |
| -------------------------------------------- | ----------------------------------------------------------------------------- |
| Nested YAML frontmatter                      | Use flat key-value pairs only                                                 |
| 10+ sections covering every possible concern | Stick to the 6 sections. Other concerns go in separate compliance processes   |
| Verbose prose paragraphs                     | Use bullet points with bold labels                                            |
| Inventing data classification labels         | Use the exact labels from the template (PII / financial / source code / none) |
| Missing Action Items section                 | Always include it — this is the remediation tracker                           |
| Adding approval/signature blocks             | Not needed — this is a living document, not a sign-off form                   |
| Using em dash in bullets                     | Use colon: `**Label**: value`                                                 |

## Numbering

There is no numbering. Vendor files are not sequentially numbered like ADRs. Use the vendor slug as the filename.
