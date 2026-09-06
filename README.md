# Meridian Field Services Implementation

> **This is a simulation, not client work.** Meridian Field Services Pty Ltd is a fictional company.
> This repository documents a self-directed Salesforce project built to develop
> and evidence implementation skills. No real customer data appears anywhere in it.

**Certification track:** Platform App Builder
**Salesforce org:** Developer Edition (CLI alias `meridian`)
**Scope:** 18 phases | data model, Lightning app, security, reporting, mobile, automation, page design, release management

## The brief

An end-to-end Salesforce implementation for a Sydney plumbing, electrical and HVAC company running its business on spreadsheets and a group text thread.

## What's in here

| Folder | Contents |
|---|---|
| `force-app/` | Salesforce metadata retrieved from the org — the configuration itself |
| `seed/` | Apex scripts that build the starting data, including its deliberate defects |
| `deliverables/` | The written work: design docs, SOPs, analyses, runbooks |
| `evidence/` | Before/after screenshots and test results per phase |

`deliverables/` is the substance. The configuration proves the clicks happened;
the documents prove the thinking did.

## Progress

| Phase | | Status |
|---:|---|---|
| 1 | Data model and relationships | **Built** |
| 2–18 | App, security, automation, reporting, mobile, release, handover | Planned |

The full plan — scope, deliverables and acceptance criteria for all 18 phases —
is in [`deliverables/implementation-plan.md`](deliverables/implementation-plan.md).
Phase 1's design and the reasoning behind it is in
[`deliverables/01-data-model-design.md`](deliverables/01-data-model-design.md).

Build log lives in `deliverables/build-log.md` — every change with its date,
reason, and the requirement it traces to.

## Running it

```bash
sf org login web --alias meridian
sf project deploy start --target-org meridian
sf apex run --file seed/01_accounts_contacts.apex --target-org meridian
sf apex run --file seed/02_technicians.apex       --target-org meridian
sf apex run --file seed/03_service_jobs.apex      --target-org meridian
sf apex run --file seed/04_job_line_items.apex    --target-org meridian
```

The seed scripts load deliberately defective data — duplicate customers,
completed jobs with no technician, electrical work with no compliance
certificate. That is the raw material for the data-quality and cleanup phases;
`seed/README.md` catalogues all 21 defect classes.

---

Built by [Hemayet Hossain](https://github.com/hossainconsulting) · Sydney, Australia
Portfolio: [portfolio.hossainconsulting.com](https://portfolio.hossainconsulting.com)
