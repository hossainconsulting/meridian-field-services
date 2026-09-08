# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working in this project.

## What this is

Engagement workspace for the **Meridian Field Services Pty Ltd** simulation, the
**Platform App Builder** certification track. Hemayet plays the consultant; the company
and every record in it are fictional. See `README.md` for the brief and scope.

## The org

Target org alias **`meridian`**, a Developer Edition org authorised locally.

```bash
sf org display --target-org meridian
sf data query --target-org meridian --query "SELECT COUNT() FROM Account"
```

## The division of labour

**Hemayet builds all Setup configuration by hand.** The certifications test Setup
navigation and so does the job. Do not build config via the Metadata API on his behalf
unless he asks explicitly.

**Claude does:** seed data (Apex anonymous), verification queries, code review,
deployment mechanics, documentation drafting, and playing stakeholders in character.

## Where things go

- `force-app/` is metadata retrieved from the org after Hemayet has built it.
- `seed/` holds the Apex scripts that build the starting data, defects included.
- `deliverables/` is the product of the engagement. `deliverables/build-log.md` records
  every change with its date, reason and the requirement it traces to.
- `evidence/` holds before/after screenshots and test results.

## Claude + Salesforce tooling

This repo is set up for Claude Code to talk to the org directly. Full setup and
the reasoning behind it: [runbook-claude-code-salesforce.md](https://github.com/hossainconsulting/agentforce-meridian-care/blob/main/deliverables/runbook-claude-code-salesforce.md).

- **`.mcp.json`** starts the Salesforce DX MCP server pinned to the **`meridian`**
  alias with the `data`, `metadata` and `testing` toolsets. It is pinned on purpose:
  this machine holds several org authorisations and `DEFAULT_TARGET_ORG` would follow
  whatever was last set as default. If the alias is not authorised locally, run
  `sf org login web --alias meridian` first.
- **`.claude/settings.json`** enables that server and the official
  `salesforce-development` plugin (skills, deploy safety gate, Apex/SOQL language
  servers). Install it once per machine with
  `/plugin install salesforce-development@claude-plugins-official`, then run
  `/salesforce-development:setup` to check prerequisites.

Rules that the tooling does not change:

- The plugin can generate objects, fields, flows and permission sets. **Do not**,
  unless asked explicitly. Hemayet builds Setup configuration by hand.
- Read before write. Verification queries and `retrieve_metadata` into `force-app/`
  are routine. `deploy_metadata`, record deletes and anything that changes the org
  need an explicit ask in the conversation, every time.
- Seed and fix-up scripts run as anonymous Apex (`sf apex run --file`), are kept in
  `seed/` or `scripts/`, and are logged in `deliverables/build-log.md` like any
  other change.
