# Project context — meridian-field-services

Read [AGENTS.md](AGENTS.md) before working in this repository.

Platform App Builder simulation for fictional Meridian Field Services.

## Audit baseline — 2026-09-22

- Intended org alias: meridian.
- Package directory: force-app; source API version: 67.0.
- Org-to-repository metadata parity: unverified.

The intended alias is documented but was not authenticated in the audited WSL environment. The 18-phase scope is planned work. The build log has no completed entries, and no tracked files under force-app/main/default were found.

Absence of tracked metadata does not establish absence of org configuration.

## Navigation

- AGENTS.md: engineering, authorization and verification guidance.
- README.md: scenario, scope and status.
- sfdx-project.json: package directories and source API version.
- force-app/: configured package directory; inspect tracked contents.
- deliverables/: project documents and build history.
- evidence/: inspect contents before claiming evidence exists.

At the audit baseline, no config/, manifest/ or docs/ directories were found.
Check current files before referencing a manifest, scratch-org definition or tests.

## Workflow

1. Read AGENTS.md and relevant project documents.
2. Inspect Git status and preserve unrelated work.
3. Separate scenario assumptions, repository evidence and verified org state.
4. Verify the target org and use an explicit --target-org where supported.
5. Scope retrieval or implementation and review the resulting diff.
6. Run appropriate checks and record results and limitations.

Do not retrieve all metadata automatically. A clean Git tree does not prove
org synchronization. Follow AGENTS.md before deployments or data changes.

## Inspection commands

Run these individually from the project root:

    git status -sb
    git ls-files force-app
    cat sfdx-project.json
    sf --version
    sf org list --all
    sf config list
    git diff --check

Check installed CLI help before unfamiliar commands. Keep credentials,
access tokens and authentication URLs out of shared output.

## Testing and delivery

Review documentation content, links and whitespace.
For code or metadata changes, identify available tests and the target environment
before choosing validation. No automated test workflow was verified in this audit.
Record actual results; do not claim unexecuted tests passed.

Git publication is separate from Salesforce deployment. Use synthetic data
and keep private information out of public evidence.
