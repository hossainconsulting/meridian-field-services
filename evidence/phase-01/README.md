# Evidence — Phase 1, data model

Screenshots to capture from the org after deploying this phase. Named as listed
so the design document can reference them.

| File | What it shows |
|---|---|
| `01-schema-builder.png` | Schema Builder with Service Job, Job Line Item, Technician and Account, relationships visible |
| `02-service-job-fields.png` | Object Manager field list for Service Job, descriptions column visible |
| `03-rollup-verification.png` | An invoiced job showing line items and Total Job Value equal to lines plus callout fee |
| `04-certificate-formula.png` | Two jobs side by side — an Electrical job with Requires Compliance Certificate true, a Plumbing job with it false |
| `05-seed-load-output.png` | Terminal output of the four seed scripts with the record counts |
| `06-defect-list-view.png` | Unassigned Jobs list view showing the D13 completed-with-no-technician records |
| `07-deploy-success.png` | `sf project deploy start` completing without errors |

Screenshots are taken after `seed/00_reset.apex` and a full reload, so counts
match `seed/README.md`.
