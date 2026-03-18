---
description: Use when creating or updating disaster recovery documentation for a service — covers RPO/RTO targets, failure scenarios, rebuild procedures, and DR test schedules. Triggers on "disaster recovery", "DR plan", "RPO", "RTO", "failover docs".
---

# Writing Disaster Recovery Documentation

## Overview

Write disaster recovery documentation files for platform services. Each service gets one Markdown file in `docs/disaster-recovery/` with a fixed section structure covering recovery objectives, durability model, failure scenarios, full rebuild procedure, and DR test schedule.

## When to Use

- Creating disaster recovery documentation for a new service
- Updating recovery objectives after infrastructure changes
- Adding new failure scenarios discovered through incidents or DR tests
- Adjusting DR test schedule or rebuild procedures

## Template

Every disaster recovery file MUST use this exact structure. Do not add, remove, rename, or reorder sections.

````markdown
# Disaster Recovery — {service-name} <!-- required -->

<!-- section: recovery-objectives -->

## Recovery Objectives <!-- required -->

<!-- Table defining RPO and RTO targets with justification. -->

| Metric | Target      | Basis                                          |
| ------ | ----------- | ---------------------------------------------- |
| RPO    | **N hours** | Justification for the recovery point objective |
| RTO    | **N hours** | Justification for the recovery time objective  |

---

<!-- section: durability-model -->

## Durability Model <!-- required -->

<!-- Describe how data is persisted and protected against loss.
     Cover: replication, backup frequency, encryption, retention. -->

Describe the durability guarantees provided by the underlying infrastructure.

---

<!-- section: failure-scenarios -->

## Failure Scenarios <!-- required -->

<!-- One subsection per failure scenario. Cover the most likely and most severe
     failure modes. Each scenario should include the action to take and expected
     recovery time. -->

### Scenario 1: <Failure mode name>

- **Action:** Describe the recovery action (automatic or manual).
- **Expected recovery time:** Estimate based on infrastructure characteristics.

### Scenario 2: <Failure mode name>

- **Action:** Describe the recovery action.
- **Expected recovery time:** Estimate.

---

<!-- section: full-rebuild-procedure -->

## Full Rebuild Procedure <!-- required -->

<!-- Step-by-step procedure to rebuild the service from scratch.
     Include actual commands (Pulumi, AWS CLI, psql, etc.) where possible. -->

1. **Reprovision infrastructure** via Pulumi:

   ```bash
   pnpm pulumi up --stack au-prod --yes
   ```

2. **Restore data** from backup or replay source.

3. **Validate** the restored service is functional (health checks, smoke tests).

4. **Redirect traffic** to the restored instance.

5. **Decommission** the failed resources.

---

<!-- section: dr-test-schedule -->

## DR Test Schedule <!-- required -->

<!-- Table of periodic DR tests with frequency, description, and owner. -->

| Test                | Frequency | Description                                                              | Owner            |
| ------------------- | --------- | ------------------------------------------------------------------------ | ---------------- |
| Backup verification | Monthly   | Confirm backups are completing successfully                              | On-call engineer |
| Restore drill       | Quarterly | Restore from backup to a temporary environment; run smoke tests; destroy | Platform team    |
| Full DR simulation  | Annually  | Simulate complete service loss; measure actual RTO                       | Engineering lead |
````

## Section Rules

- **No frontmatter.** Disaster recovery files have no YAML frontmatter — they start with the H1 heading.
- **H1 heading format** — `# Disaster Recovery — <service-name>` using em dash.
- **Five required sections** — Recovery Objectives, Durability Model, Failure Scenarios, Full Rebuild Procedure, DR Test Schedule. All must be present.
- **Recovery Objectives table** — must have both RPO and RTO rows with concrete targets and justifications.
- **Durability Model** — must cover replication, backup frequency, encryption, and retention.
- **Failure scenarios** — use `### Scenario N: <Name>` headings with sequential numbering. Each scenario must have **Action** and **Expected recovery time** fields.
- **Full Rebuild Procedure** — use numbered steps with actual commands (Pulumi, AWS CLI, psql, etc.) in code blocks. Do not use placeholder commands.
- **DR Test Schedule** — table must have Test, Frequency, Description, and Owner columns. Keep the standard three tests (Backup verification, Restore drill, Full DR simulation) and add service-specific tests as needed.
- **HTML comments** — preserve `<!-- section: name -->` comments and `<!-- required -->` markers.
- **Horizontal rules** — use `---` between sections as shown in the template.

## File Naming

- One file per service: `services/<service>/docs/disaster-recovery.md`
- Lives inside the service directory, not in the repo-wide `docs/` folder

## Common Mistakes

| Mistake                                       | Fix                                                                           |
| --------------------------------------------- | ----------------------------------------------------------------------------- |
| Adding YAML frontmatter                       | DR files have no frontmatter — start with the H1 heading                      |
| Missing RPO or RTO in Recovery Objectives     | Both RPO and RTO must be present with targets and justifications               |
| Vague failure scenarios without recovery times | Every scenario must have Action and Expected recovery time                    |
| Placeholder commands in rebuild procedure     | Use actual commands (Pulumi, AWS CLI, psql) — not pseudocode                  |
| Missing DR Test Schedule                      | Always include it — even simple services need periodic validation             |
| Using free-form headings for scenarios        | Use `### Scenario N: <Name>` format with sequential numbering                 |
| Removing HTML section comments                | Preserve all `<!-- section: name -->` comments                                |
| Omitting Durability Model details             | Cover replication, backup frequency, encryption, and retention                |
