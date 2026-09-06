# Implementation plan — Meridian Field Services

> **Simulation.** Meridian Field Services Pty Ltd is fictional. This plan
> describes a self-directed Salesforce implementation built to develop and
> evidence Platform App Builder skills. No real customer data is involved.

## The brief, in one paragraph

Meridian is a Sydney plumbing, electrical and HVAC company. Eight field workers,
about 40 jobs a week, run entirely on a shared spreadsheet and a group text
thread. Jobs get double-booked, compliance certificates go unrecorded, invoices
go out with nothing on them, and nobody can say which customers are profitable.
They have bought Salesforce and need it configured, populated, secured,
automated, reported on and handed over.

## How this plan is used

Eighteen phases, built in order, each one a commit or a small series of them.
A phase is finished when every acceptance criterion below is demonstrably true
in the org and the deliverable documents exist in `deliverables/`. Evidence —
before and after screenshots, test output — goes in `evidence/phase-NN/`.
Every change lands in `deliverables/build-log.md` with its reason.

The phases build on each other deliberately. The security model comes after the
data model because you cannot secure fields that do not exist; the cleanup phase
comes after the validation phase because there is no point cleaning data that
the org will let go bad again the following week.

## Status

| # | Phase | Status |
|---:|---|---|
| 1 | Data model and relationships | **Built** |
| 2 | Lightning app, tabs and navigation | Not started |
| 3 | Record types and business processes | Not started |
| 4 | Compact layouts, page layouts and field placement | Not started |
| 5 | Data quality: validation and duplicate rules | Not started |
| 6 | Data cleanup and migration | Not started |
| 7 | Profiles, permission sets and field-level security | Not started |
| 8 | Sharing model: org-wide defaults, roles and sharing rules | Not started |
| 9 | Record-triggered automation | Not started |
| 10 | Screen flows and guided processes | Not started |
| 11 | Scheduled and time-based automation | Not started |
| 12 | Approval process | Not started |
| 13 | Custom report types and reports | Not started |
| 14 | Dashboards and the KPI set | Not started |
| 15 | Lightning record pages and dynamic forms | Not started |
| 16 | Mobile experience | Not started |
| 17 | Release management and deployment | Not started |
| 18 | Handover: SOPs, runbooks and UAT | Not started |

## Conventions

- **Metadata** is retrieved into `force-app/` in source format. The org is the
  scratchpad; the repository is the record.
- **Naming.** Custom objects and fields are singular and descriptive
  (`Service_Job__c`, `Compliance_Certificate_Number__c`). No abbreviations that
  need a glossary.
- **Every field carries a description.** A field without one is treated as
  incomplete work, not a minor omission — the description is what a successor
  administrator reads two years from now.
- **Declarative first.** Apex appears only where a documented limit of the
  declarative tools is reached, and the plan says so at the point it happens.

---

## Phase 1 — Data model and relationships

**Goal.** Model the business in objects and relationships, and load a starting
dataset that looks like the spreadsheet it came from.

**In scope.** Service Job, Job Line Item and Technician custom objects; their
fields, formulas and roll-ups; extensions to Account; one page layout and a set
of list views per object; the seed scripts and their defect catalogue.

**Out of scope.** Tabs and the app (Phase 2). Record types (Phase 3). Any
validation — the seed data has to be able to land in all its dirtiness (Phase 5).
Sharing beyond the default (Phase 8).

**Deliverables.**
- `force-app/main/default/objects/` — three custom objects, 52 fields
- `force-app/main/default/layouts/` — one layout per custom object
- `seed/` — four load scripts, a reset script, and the defect catalogue
- `deliverables/01-data-model-design.md` — the design and the decisions behind it

**Acceptance criteria.**
1. `sf project deploy start` completes with no errors against a clean org.
2. All four seed scripts run clean and the record counts match `seed/README.md`.
3. Total Job Value rolls up correctly on a job with mixed line types.
4. Requires Compliance Certificate is true for every Electrical and HVAC job and
   false for every Plumbing one, with no manual intervention.
5. Every custom field has a description.

**App Builder domain.** Data Modeling and Management (~22% of the exam).

---

## Phase 2 — Lightning app, tabs and navigation

**Goal.** Give the three roles — dispatcher, technician, owner — a way into the
data that matches how they work.

**In scope.** Custom tabs for each object; a Meridian Field Service Lightning
app; navigation item order and utility bar; a home page with the dispatcher's
queue.

**Out of scope.** Record page layout and dynamic forms (Phase 15). Mobile
navigation (Phase 16).

**Deliverables.** `CustomTab` and `CustomApplication` metadata;
`deliverables/02-app-and-navigation.md` covering who sees what and why.

**Acceptance criteria.**
1. The app appears in the App Launcher and opens on the dispatcher home page.
2. Navigation order is Jobs, Technicians, Accounts, Reports — dispatch first,
   because that is the first thing anyone does in the morning.
3. Every object is reachable in two clicks from the app home.

**App Builder domain.** Salesforce Fundamentals; User Interface.

---

## Phase 3 — Record types and business processes

**Goal.** Separate the job types that genuinely behave differently, without
creating record types for their own sake.

**In scope.** Record types for Emergency Callout and Planned Work on Service Job;
picklist value sets scoped per record type; the decision record for which
distinctions justify a record type and which are just a picklist value.

**Out of scope.** Assignment of record types to profiles (Phase 7).

**Deliverables.** `RecordType` metadata; `deliverables/03-record-types.md`
including the rejected options and why they were rejected.

**Acceptance criteria.**
1. Emergency Callout jobs default to P1 and require a callout fee.
2. Planned Work jobs cannot be set to P1.
3. The document names at least two distinctions considered and rejected as
   not warranting a record type.

**App Builder domain.** Data Modeling and Management; Business Logic.

---

## Phase 4 — Compact layouts, page layouts and field placement

**Goal.** Make the record readable at a glance for the person holding a phone in
one hand and a wrench in the other.

**In scope.** Compact layouts per object and record type; refined page layouts;
related list field selection and sort order; help text review across all fields.

**Out of scope.** Dynamic forms and conditional visibility (Phase 15).

**Deliverables.** Updated `Layout` and new `CompactLayout` metadata;
`deliverables/04-layout-design.md`; before and after screenshots.

**Acceptance criteria.**
1. The highlights panel answers "who, where, when, what state" without scrolling.
2. No layout puts a currency field above the work description on a job — the
   technician's information comes first, the accountant's second.
3. Every field with a non-obvious meaning has help text.

**App Builder domain.** User Interface.

---

## Phase 5 — Data quality: validation and duplicate rules

**Goal.** Close the door on every defect class in the seed catalogue that can be
prevented at entry.

**In scope.** Validation rules on Service Job, Job Line Item and Technician;
matching and duplicate rules on Account and Service Job; required-field and
picklist restrictions.

**Out of scope.** Cleaning the existing defects (Phase 6). Anything requiring
cross-record logic that a validation rule cannot express (Phase 9).

**Deliverables.** `ValidationRule`, `MatchingRule` and `DuplicateRule` metadata;
`deliverables/05-data-quality.md` mapping each rule to the defect ID it stops,
with the error message text and where it appears.

**Acceptance criteria.**
1. Every one of D10–D14, D16, D19 and D20 is blocked on new or edited records.
2. Re-running seed script 03 against the hardened org fails on exactly the
   records that carry those defects, and no others.
3. Each error message names the field and says what to do, not what went wrong.
4. Defects the rules deliberately do not block are listed with the reason.

**App Builder domain.** Business Logic; Data Modeling and Management.

---

## Phase 6 — Data cleanup and migration

**Goal.** Clean the 21 defect classes out of the existing data, using the tools
a real migration would use, and measure the result.

**In scope.** Export to CSV; deduplication and merge of the three account pairs
and two job pairs; phone, state and email normalisation; backfill of missing
suburbs and postcodes; reload via Data Loader; a before-and-after defect count.

**Out of scope.** Ongoing monitoring (Phase 13 reports).

**Deliverables.** `deliverables/06-data-cleanup.md` — the method, the field
mapping, the decisions on ambiguous records, and a before/after table by defect
ID; the working CSVs; the Data Loader configuration.

**Acceptance criteria.**
1. Defect count by ID drops to zero for D1–D8, D13, D14, D16, D17 and D19.
2. No record is lost: account count reconciles to 17 after merges, job count
   to 45 after the two duplicate pairs collapse.
3. The document states what was done with every record that could not be
   resolved mechanically, and who would decide it in a real engagement.

**App Builder domain.** Data Modeling and Management.

---

## Phase 7 — Profiles, permission sets and field-level security

**Goal.** Give each role the minimum access that lets them do their job.

**In scope.** A Technician profile and a Dispatcher profile; permission sets for
the things that cut across them (compliance certificate entry, invoice number
entry); field-level security, notably hiding charge rate and job value from
field staff.

**Out of scope.** Record-level visibility (Phase 8).

**Deliverables.** `Profile`, `PermissionSet` metadata;
`deliverables/07-security-model.md` part 1 — a matrix of role against object and
field permission, with the reasoning for each restriction.

**Acceptance criteria.**
1. A technician cannot see Hourly Charge Rate or Total Job Value on any layout,
   in any report, or through the API.
2. Only the dispatcher and owner can edit Invoice Number.
3. Permission sets, not profiles, carry every optional capability.

**App Builder domain.** Security (~10% of the exam).

---

## Phase 8 — Sharing model: org-wide defaults, roles and sharing rules

**Goal.** Move Service Job from Public Read/Write to Private and give access
back deliberately.

**In scope.** Org-wide defaults; a three-level role hierarchy; a sharing rule
giving technicians access to jobs assigned to them; the owner's full visibility.

**Out of scope.** Territory management and Experience Cloud — both out of
proportion to a company of eight.

**Deliverables.** `SharingRules` and `Role` metadata;
`deliverables/07-security-model.md` part 2 — the sharing design with the
access-path diagram.

**Acceptance criteria.**
1. Service Job org-wide default is Private.
2. A technician logged in as themselves sees jobs assigned to them and no others.
3. The dispatcher sees everything; the change is achieved by role, not by
   sharing rules stacked on top of each other.
4. Job Line Item remains Controlled by Parent and is never shared separately.

**App Builder domain.** Security.

---

## Phase 9 — Record-triggered automation

**Goal.** Automate the status transitions and assignments that people currently
do by text message.

**In scope.** Record-triggered flows: stamp Actual Start when status moves to
In Progress; stamp Actual End on Completed; notify the dispatcher when a P1 job
goes unassigned for more than an hour; block assignment to a technician not
licensed for the job's trade (defect D21).

**Out of scope.** Anything user-facing and interactive (Phase 10). Anything on
a schedule (Phase 11).

**Deliverables.** `Flow` metadata; `deliverables/09-automation-design.md` with a
flow-by-flow trigger, entry criteria, and the bulkification check.

**Acceptance criteria.**
1. Each flow is documented with its entry criteria and what it deliberately
   does not fire on.
2. No flow performs a DML or a get inside a loop.
3. The trade-licence check rejects the three D21 assignments and permits every
   correctly matched one.
4. A single bulk update of 200 jobs stays inside limits.

**App Builder domain.** Business Logic and Process Automation (~28% — the
largest single domain).

---
## Phase 10 — Screen flows and guided processes

**Goal.** Replace the two jobs on the whiteboard that nobody does correctly:
logging a new emergency callout, and closing a job out on site.

**In scope.** A New Emergency Callout screen flow that captures customer, site,
problem and priority in one pass and creates the job assigned and scheduled; a
Complete Job flow that walks the technician through work performed, line items,
certificate number and signature.

**Out of scope.** Mobile-specific presentation (Phase 16).

**Deliverables.** `Flow` metadata; `deliverables/10-guided-processes.md` with
the screen-by-screen design and the reasoning about what to ask and what to
infer.

**Acceptance criteria.**
1. A new emergency callout can be logged in under 60 seconds from the app home.
2. The completion flow will not finish without the fields the Phase 5 rules
   require, and says so before the last screen rather than after it.
3. Both flows are launchable from an action on the record page.

**App Builder domain.** Business Logic and Process Automation; User Interface.

---

## Phase 11 — Scheduled and time-based automation

**Goal.** Catch the things that go wrong through inaction rather than action.

**In scope.** A daily scheduled flow that flags jobs left In Progress for more
than seven days (defect D15); a weekly flow warning on licences expiring within
30 days (D9); an email alert to the owner summarising both.

**Out of scope.** Anything requiring an external scheduler or Apex batch — the
volumes do not justify either, and the document says so.

**Deliverables.** `Flow` metadata; `deliverables/11-scheduled-automation.md`
including the run schedule and what happens when a run fails.

**Acceptance criteria.**
1. The stale-job sweep identifies exactly the five D15 jobs on a freshly
   seeded org.
2. The licence warning fires for Tane Ropata (12 days out) and for the two
   already-expired licences, and for nobody else.
3. Failure handling is defined: a failed scheduled run notifies a named person.

**App Builder domain.** Business Logic and Process Automation.

---

## Phase 12 — Approval process

**Goal.** Put a control on the two things that cost money when they go wrong:
large quotes and after-hours callouts.

**In scope.** An approval process on Service Job triggered above a value
threshold; entry criteria, approver, and the record lock; the recall path.

**Out of scope.** Multi-step approval chains — one approver is the right answer
for a company of eight, and the document explains why adding a second is a cost
without a benefit here.

**Deliverables.** `ApprovalProcess` metadata;
`deliverables/12-approval-process.md` with the process diagram and the field
updates at each step.

**Acceptance criteria.**
1. A job over the threshold cannot move to Invoiced without approval.
2. Locked records are genuinely locked — verified as the technician, not just
   as the administrator.
3. The recall path is tested and documented.

**App Builder domain.** Business Logic and Process Automation.

---

## Phase 13 — Custom report types and reports

**Goal.** Answer the questions the owner currently cannot answer at all.

**In scope.** Custom report types spanning Job with Line Items, and Technician
with Jobs; the report set — revenue by customer type, job volume by suburb,
first-time fix rate, warranty return rate, ageing open jobs, and a data-quality
report per remaining defect class.

**Out of scope.** Dashboards (Phase 14). Einstein or CRM Analytics — out of
proportion.

**Deliverables.** `ReportType` and `Report` metadata;
`deliverables/13-reporting.md` stating, for each report, the business question
it answers and who reads it.

**Acceptance criteria.**
1. Every report traces to a question in the brief.
2. The warranty return rate report is correct on the seeded data, verified by
   hand against the two warranty jobs.
3. A data-quality report exists for each defect class that survives Phase 6, so
   quality is monitored rather than assumed.

**App Builder domain.** Reporting (~5%).

---

## Phase 14 — Dashboards and the KPI set

**Goal.** One screen the owner looks at on Monday morning.

**In scope.** A dispatcher operational dashboard (today's schedule, unassigned
P1s, stale jobs) and an owner dashboard (revenue by month and customer type,
technician utilisation, first-time fix rate); dynamic dashboards where the
viewer's access should change what they see.

**Out of scope.** Subscriptions and scheduled refresh beyond the default.

**Deliverables.** `Dashboard` metadata; `deliverables/14-dashboards.md`
including the definition of each KPI — how utilisation is calculated, and what
counts as a first-time fix.

**Acceptance criteria.**
1. Every KPI has a written definition that two people would compute the same way.
2. The dispatcher dashboard loads with no component requiring a scroll.
3. Technician utilisation excludes warranty returns, and the document says why.

**App Builder domain.** Reporting; User Interface.

---

## Phase 15 — Lightning record pages and dynamic forms

**Goal.** Make one record page serve three roles by showing each of them a
different subset of the same record.

**In scope.** A Lightning record page for Service Job using Dynamic Forms;
conditional field visibility — the certificate number appears only when
required, the invoice number only after completion; component visibility by
record type and by user profile.

**Out of scope.** Custom Lightning web components. If a page needs one, that is
a signal the requirement has drifted beyond App Builder scope, and the document
records the boundary.

**Deliverables.** `FlexiPage` metadata; `deliverables/15-record-pages.md` with
the visibility matrix.

**Acceptance criteria.**
1. Compliance Certificate Number is visible only when Requires Compliance
   Certificate is true.
2. The billing section is hidden entirely from the Technician profile — belt and
   braces over the Phase 7 field-level security, not instead of it.
3. The page is assigned by app and record type, not org-wide.

**App Builder domain.** User Interface (~17%).

---

## Phase 16 — Mobile experience

**Goal.** The technician never opens a laptop. The phone has to be the whole
product for them.

**In scope.** Mobile-optimised compact layouts; mobile quick actions for start
job, complete job and add line item; the Salesforce mobile app navigation for
the Technician profile; geolocation capture on arrival.

**Out of scope.** A custom mobile app or offline briefcase configuration beyond
the standard.

**Deliverables.** `QuickAction` metadata and mobile navigation configuration;
`deliverables/16-mobile.md` with a walkthrough of the technician's day as a
sequence of taps, and screenshots from a phone.

**Acceptance criteria.**
1. A technician can complete a job end to end on a phone in under two minutes.
2. The first three fields on the mobile compact layout are address, customer
   phone and reported problem — in that order, because that is the order the
   technician needs them.
3. No action on the mobile layout requires horizontal scrolling.

**App Builder domain.** User Interface; Mobile.

---

## Phase 17 — Release management and deployment

**Goal.** Be able to change this org without breaking it, and prove the change
was deliberate.

**In scope.** Source-tracked development against a scratch org; a deployment
runbook; a GitHub Actions workflow validating metadata on push; the sandbox
strategy a real client would need; the change-set path documented as the
fallback for admins without CLI access.

**Out of scope.** A full CI/CD pipeline with automated Apex test gates —
proportionate for a company of eight, and the document says what would change
that.

**Deliverables.** `.github/workflows/`; `deliverables/17-release-management.md`
covering the branching model, the validation deploy, and the rollback plan.

**Acceptance criteria.**
1. A push to a feature branch runs a validate-only deployment against a scratch
   org and fails the build on a metadata error.
2. The runbook is specific enough that someone else could deploy from it
   without asking a question.
3. Rollback is documented and has been tested at least once.

**App Builder domain.** App Deployment (~10%).

---

## Phase 18 — Handover: SOPs, runbooks and UAT

**Goal.** Leave behind something a successor can run without you.

**In scope.** Standard operating procedures for the dispatcher and the
technician; an administrator runbook; a UAT script with test cases traced to the
brief; a training one-pager per role; the final build log.

**Out of scope.** Ongoing support — the document states what a support
arrangement would need to cover.

**Deliverables.** `deliverables/18-handover/` — SOPs, runbook, UAT script and
results, training material.

**Acceptance criteria.**
1. Every requirement in the brief traces to a phase, a component and a UAT case.
2. The UAT script has been executed and the results recorded, failures included.
3. The build log covers every change made across all 18 phases.
4. A reader who has never seen the org can find any component from the
   documentation alone.

**App Builder domain.** All — this is the phase that turns configuration into
an implementation.

---

## What this plan deliberately leaves out

Field Service Lightning would be the product answer for a company like this, and
a real engagement would evaluate it before building anything custom. It is out
of scope here for two reasons: the licence cost is not proportionate to eight
field workers, and the point of the exercise is to demonstrate configuration
skill on the core platform rather than to configure a managed package.
`deliverables/01-data-model-design.md` records that trade-off properly.

Apex is not in the plan. Where a phase reaches the limit of the declarative
tools, the plan says so at that point rather than reaching for code by default.
The Apex work in this portfolio lives in a separate project where it is the
subject rather than a shortcut.
