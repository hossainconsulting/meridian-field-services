# Seed data

Apex scripts that build the Meridian starting dataset in a Developer Edition or
scratch org. They load **deliberately defective data**. That is the point: the
brief is a business coming off spreadsheets and a group text thread, and the
value of the later phases is only visible if the starting data looks like it
came from there.

Do not clean these scripts up. Phase 5 stops new defects at the door with
validation and duplicate rules; Phase 6 cleans the existing ones up and measures
the result. Both phases need this mess to exist first.

## Run order

```bash
sf apex run --file seed/01_accounts_contacts.apex --target-org meridian
sf apex run --file seed/02_technicians.apex       --target-org meridian
sf apex run --file seed/03_service_jobs.apex      --target-org meridian
sf apex run --file seed/04_job_line_items.apex    --target-org meridian
```

`seed/00_reset.apex` deletes every Account, Contact, Technician and Service Job
in the target org so the load can be repeated from a known state. It is
destructive and indiscriminate — only ever point it at the project org.

Scripts 01–03 hold their records inline. Script 04 generates line items from
whatever jobs are already in the org, so it can be re-run after a partial load.
Every script inserts with `Database.insert(list, false)` and logs failures
rather than rolling the whole batch back, because a partial load that tells you
what failed is more useful here than an all-or-nothing one.

## What gets loaded

| Object | Records | Notes |
|---|---:|---|
| Account | 20 | 17 real customers, 3 of them duplicated |
| Contact | 22 | one or two per account |
| Technician | 8 | 5 employees, 3 subcontractors |
| Service Job | 47 | 19 clean, 28 carrying at least one defect |
| Job Line Item | ~70 | generated from closed jobs |

## Defect catalogue

The numbering is stable and referenced from the seed scripts, the Phase 5
validation design and the Phase 6 cleanup report. Defects overlap on purpose —
real data does not arrive one problem per row, and several jobs below are
simultaneously unassigned, missing a suburb and missing a certificate.

| ID | Defect | Count | Where | Cleared in |
|---|---|---:|---|---|
| D1 | Duplicate customer records under near-match names | 3 pairs | Account | Phase 5 (duplicate rules), Phase 6 (merge) |
| D2 | Phone numbers in mixed formats, one account with none | 8 variants | Account | Phase 6 |
| D3 | Missing billing postcode | 5 | Account | Phase 6 |
| D4 | Billing state as free text: `New South Wales`, `nsw`, `N.S.W.` | 3 | Account | Phase 6 |
| D5 | Name casing and trailing-whitespace variants | 2 | Account | Phase 6 |
| D6 | Customer type not set | 4 | Account | Phase 5 (required on layout), Phase 6 |
| D7 | Malformed email: typo TLD, typo domain, missing TLD, embedded space | 4 | Contact | Phase 6 |
| D8 | Contact with no phone or mobile at all | 2 | Contact | Phase 6 |
| D9 | Licence expired, or no licence recorded | 3 | Technician | Phase 5, Phase 11 (expiry alert) |
| D10 | Future work assigned to a technician who is off the roster | 2 | Service Job | Phase 5 |
| D11 | Scheduled end before scheduled start | 3 | Service Job | Phase 5 |
| D12 | Actual end before actual start | 2 | Service Job | Phase 5 |
| D13 | Completed with no technician recorded | 4 | Service Job | Phase 5 |
| D14 | Completed electrical or HVAC work with no compliance certificate number | 5 | Service Job | Phase 5 |
| D15 | Left In Progress for 60–96 days | 5 | Service Job | Phase 11 (scheduled sweep) |
| D16 | Invoiced with no line items, so job value is zero | 3 | Service Job | Phase 5, Phase 6 |
| D17 | Missing service suburb and postcode | 7 | Service Job | Phase 6 |
| D18 | The same job logged twice a day apart | 2 pairs | Service Job | Phase 5 (duplicate rules) |
| D19 | Part fitted and priced at zero | 6 | Job Line Item | Phase 5 |
| D20 | Labour quantity keyed as 40 hours instead of 4.0 | 2 | Job Line Item | Phase 5 |
| D21 | Job assigned to a technician not licensed for that trade | 3 | Service Job | Phase 9 (assignment logic) |

The trailing-space duplicate in D5 may be trimmed on insert depending on org
settings; if it is, that pair collapses into an exact-name duplicate, which the
Phase 5 duplicate rule should still catch.

## Why Apex and not a CSV load

The Phase 6 data migration project uses CSV and Data Loader deliberately, and
documents that path. Seeding is a different problem: it has to run repeatably
from a clean org with relationships intact, which means resolving parent IDs at
run time. Apex does that in one step; a CSV load needs an ID-mapping pass
between every file.
