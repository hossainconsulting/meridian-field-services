# Build log — Meridian Field Services Implementation

Every change, with the reason and the requirement it traces to. This is the
artefact that survives the project and the one an auditor or a successor reads.

Requirement references are to the brief as recorded in
`deliverables/implementation-plan.md`. Defect IDs (D1–D21) are the seed data
defect catalogue in `seed/README.md`.

## Phase 1 — Data model and relationships

| Date | Component | Type | Change | Why / requirement |
|---|---|---|---|---|
| 2026-09-04 | — | Plan | 18-phase implementation plan with scope, deliverables and acceptance criteria per phase | The brief covers eight domains; without a sequence the security model gets built before the fields exist |
| 2026-09-04 | `Service_Job__c` | Object | Created. Auto-number `JOB-{00000}`, activities and history enabled, Public Read/Write | The unit of work the whole business is organised around |
| 2026-09-04 | `Service_Job__c` | Field | 29 fields across relationships, classification, site address, scheduling, work performed and billing | See `deliverables/01-data-model-design.md` for the field-by-field rationale |
| 2026-09-04 | `Service_Job__c.Account__c` | Field | Required lookup, delete restricted | A customer with job history must not be deletable |
| 2026-09-04 | `Service_Job__c.Service_Street__c` … `Service_Postcode__c` | Field | Site address held on the job, separate from the account billing address | Strata, agent and housing-trust customers are billed at one address and served at many |
| 2026-09-04 | `Service_Job__c.Service_State__c` | Field | Restricted picklist rather than text | Legacy data held NSW, nsw, N.S.W. and New South Wales for one state (D4) |
| 2026-09-04 | `Service_Job__c.Requires_Compliance_Certificate__c` | Field | Formula on Service Type, not a manual checkbox | The obligation is a fact about the trade; a checkbox can be unticked to close a job (D14) |
| 2026-09-04 | `Service_Job__c.Response_Due__c` | Field | Formula from Priority and CreatedDate | A stored deadline goes stale the first time a priority changes |
| 2026-09-04 | `Service_Job__c.Status__c` | Field | Restricted picklist, 8 values, history tracked | Status changes are the most disputed field in the business |
| 2026-09-04 | `Service_Job__c.Invoice_Number__c` | Field | Unique, external ID | Lets the finance integration upsert rather than match by hand |
| 2026-09-04 | `Job_Line_Item__c` | Object | Created. Master-detail to Service Job, Controlled by Parent | Roll-up summaries require master-detail; a line has no meaning without its job |
| 2026-09-04 | `Job_Line_Item__c.Service_Job__c` | Field | Reparenting disabled | Rebilling a line to a different job should be visible, not silent |
| 2026-09-04 | `Job_Line_Item__c.Line_Total__c` | Field | Formula, not stored | A stored total can drift from quantity and price |
| 2026-09-04 | `Technician__c` | Object | Created as a custom object rather than using User | Half the field workforce are subcontractors with no login who still need licences tracked and jobs assigned |
| 2026-09-04 | `Technician__c.Licence_Number__c` | Field | Unique | Two technicians sharing a licence number means one record is wrong |
| 2026-09-04 | `Technician__c.Licence_Status__c` | Field | Formula returning Unknown when no expiry is recorded | A missing licence date is a compliance problem, not a neutral value (D9) |
| 2026-09-04 | `Account` | Field | Added Customer Type, Site Access Notes, Preferred Technician | Segmentation for reporting; standing access instructions held once rather than retyped per job |
| 2026-09-04 | Layouts | Layout | One page layout per custom object, sectioned job / site / scheduling / work / billing | Technician information above accountant information |
| 2026-09-04 | List views | List view | 5 on Service Job, 2 on Technician, 1 on Job Line Item | Dispatcher opens Unassigned Jobs and Emergency Queue first thing each morning |
| 2026-09-04 | `seed/` | Data | Four load scripts plus a destructive reset; 20 accounts, 22 contacts, 8 technicians, 47 jobs, ~70 line items | Phase 5 and 6 need real defects to work against |
| 2026-09-04 | `seed/README.md` | Doc | 21 numbered defect classes with counts and the phase that clears each | Makes the cleanup measurable rather than assertable |
| 2026-09-04 | `deliverables/01-data-model-design.md` | Doc | Design, ERD, decisions and open questions | Records the FSL trade-off and the four questions the assumptions rest on |

### Deliberately deferred

| Item | Deferred to | Why |
|---|---|---|
| Tabs and the Lightning app | Phase 2 | Objects first, navigation second |
| Record types | Phase 3 | Needs the job-versus-quote question answered first |
| Validation rules | Phase 5 | The seed data must be able to land in all its dirtiness |
| Private sharing and role hierarchy | Phase 8 | Designed against roles that have been thought through, not configured on day one |
| Compliance certificate enforcement | Phase 5 | The field exists now; the rule that requires it comes with the other data-quality work |
