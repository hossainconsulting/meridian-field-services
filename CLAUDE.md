# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working in this project.

## What this is

Engagement workspace for the **Meridian Field Services** implementation — an
18-phase Platform App Builder simulation. Hemayet plays the implementation
consultant at a fictional Sydney plumbing, electrical and HVAC company running
its business on spreadsheets and a group text thread.

The certification track is **Platform App Builder**, so the work is declarative
build: data model, Lightning app, security, reporting, mobile, automation, page
design, release management. Apex is not the point here and mostly should not
appear outside `seed/`.

## The org

Target org alias **`meridian`** — a dedicated Developer Edition org. Do not build
into another program org; each org is allocated to one certification track and
cross-contaminating them ruins the evidence.

```bash
sf org display --target-org meridian
sf org list metadata --metadata-type CustomObject --target-org meridian
```

Every Developer Edition org in this program has provisioned as US locale despite
Australia being selected at signup, and has arrived carrying 13 stock Salesforce
sample Accounts. Check both before seeding — see the `ironbark` and `kurrajong`
build logs for the pattern and the fix.

## The division of labour

**Hemayet builds all Setup configuration by hand** — objects, fields, record types,
page layouts, Lightning pages, flows, reports, permission sets. Platform App
Builder tests Setup navigation and so does the job. Do not build config via the
Metadata API on his behalf unless he asks explicitly.

**Claude does:** seed data (Apex anonymous in `seed/`), verification queries, ERD
and documentation drafting, build-log entries, code review, deployment mechanics,
and playing stakeholders in character for discovery exercises.

## Repository conventions

| Folder | Contents |
|---|---|
| `force-app/` | Metadata **retrieved from** the org, not authored here. It records what was clicked. |
| `seed/` | Apex anonymous scripts that build starting data, including its deliberate defects |
| `deliverables/` | The written work — design docs, SOPs, analyses, runbooks. This is the substance. |
| `evidence/` | Before/after screenshots and test results, per phase |

`deliverables/build-log.md` is the spine: every change with its date, component,
type, what changed, and the requirement it traces to. It is currently an empty
table — a phase is not finished until it has a row.

## Current state

Scaffold only. `force-app/`, `seed/` and `evidence/` hold nothing but `.gitkeep`,
and the build log has no entries. Phase 1 has not started, so do not write
documentation that implies it has.

## Rules worth enforcing in review

- The deliberate defects in seed data are the exercise. Do not quietly fix bad
  data that a phase is supposed to discover and remediate.
- Retrieved metadata should match what is actually in the org. Hand-editing
  `force-app/` to look tidier than the org makes the evidence a lie.
- Never commit an sfdx auth URL. It is a full credential — see `.gitignore`.
