# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working in this project.

## What this is

Engagement workspace for the **Meridian Field Services implementation** — eighteen
phases against the **Platform App Builder** track. An end-to-end Salesforce
implementation for a fictional Sydney plumbing, electrical and HVAC company currently
running its business on spreadsheets and a group text thread.

Meridian Field Services Pty Ltd is fictional; no real customer data is in here.

**Current state: scaffold.** `force-app/`, `seed/` and `evidence/` hold only
`.gitkeep`. Only `sfdx-project.json` (API version 67.0) exists beyond the README.

## Not the same company as Meridian Appliance Care

`agentforce-meridian-care` is a **different fictional client** — Meridian Appliance
Care Pty Ltd, a warranty administrator, on the Agentforce Specialist track. The shared
"Meridian" name is a naming collision across two engagements, not a shared org, data
model or brief. Never carry a design decision, object name or seed script between the
two without re-deriving it.

## The org

Target org alias **`meridian`** — a Developer Edition org.

```bash
sf org display --target-org meridian
sf data query --target-org meridian --query "SELECT COUNT() FROM Account"
```

Every other org in this program provisioned as US despite the signup form, and needed
Country, locale, time zone and **Currency Locale** corrected to Australian. Currency
Locale is not settable through the API in a single-currency org — Setup → Company
Information → Edit. Check this org and fix it **before seeding anything with an amount
on it**. Stock Salesforce sample data (typically 13 Accounts) should also be purged
before seeding; the pattern is `seed/00-purge-sample-data.apex` in the
**sunrise-solar-internship** repo.

## What Platform App Builder actually tests

This track is declarative build, and the review lens differs from the consultant tracks:
the question is not "did you gather the requirement" but "is this the right declarative
construct, and will it survive." Specifically —

- **Data model before anything else.** Objects, relationships and the choice between
  lookup and master-detail are the decisions everything downstream inherits. A
  master-detail chosen for convenience is the one that hurts eighteen phases later.
- **Automation belongs in one place per object.** Pick the tool deliberately (Flow vs.
  validation rule vs. formula) and record why; overlapping automation on one object is
  the classic App Builder failure.
- **Security model is part of the design, not a phase-14 afterthought** — org-wide
  defaults, role hierarchy, sharing rules and field-level security follow from the data
  model, so they get decided with it.
- **Release management is in scope** (phase 18). Whatever is built by hand must be
  retrievable into `force-app/` and describable as a deployable change set.

## The division of labour on this engagement

**Hemayet builds all Setup configuration by hand** — objects, fields, relationships,
record types, Lightning app and pages, Flows, validation rules, reports and dashboards,
mobile layouts. The certification tests Setup navigation and so does the job. Do not
build config via the Metadata API on his behalf unless he asks explicitly.

**Claude does:** seed data (Apex anonymous in `seed/`), including the deliberate defects
the engagement depends on; verification queries; evidence extraction; code review;
deployment mechanics; ERD and documentation drafting; and playing stakeholders in
character for discovery exercises.

## Documentation standards

`deliverables/` is the substance and the interview evidence. The configuration proves
the clicks happened; the documents prove the thinking did.

- **Every change goes in `deliverables/build-log.md`** with its date, the component, the
  change, and the requirement it traces to. Corrections are appended as new rows, never
  edited over.
- **Claim only what was verified** — a query or a screenshot backs every "verified".
- **Accepted risks are recorded, not hidden.** Where a training-org shortcut is taken,
  say what production would have required instead.
- **Dates are Australian** — `dd/mm/yyyy`.
- `evidence/` holds before/after extracts and screenshots per phase.

## Never commit

Auth files and sfdx auth URLs — an auth URL is a full credential. `.gitignore` covers
`**/*authFile*.json`, `**/*sfdxAuthUrl*`, `.env*`, `.sf/` and `.sfdx/`. A credential
that reaches git history has to be *rotated*, not deleted.

## Agent workflow

Superpowers is expected to be installed as a **user-level plugin**
(`/plugin install superpowers@claude-plugins-official`), not vendored into this repo.
There is no test runner here and most work is Setup configuration, so the red/green TDD
skills have little to bite on; the planning, verification and code-review skills apply
to the seed scripts and the written deliverables.
