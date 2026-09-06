/*
 * Meridian Field Services - seed data 04: billing lines.
 *
 * Run against a Developer Edition or scratch org ONLY, after 03.
 * Defect classes seeded by this script: D16 (by omission), D19, D20.
 * See seed/README.md.
 *
 * Lines are generated from the jobs already in the org rather than hard-coded,
 * so the script can be re-run after a partial load without hand-editing IDs.
 *
 * Run:  sf apex run --file seed/04_job_line_items.apex --target-org meridian
 */

// D16: these three jobs are invoiced but will deliberately receive no lines,
// so Total Job Value stays at zero on an invoiced job.
Set<String> noLineInvoices = new Set<String>{ 'INV-9001', 'INV-9002', 'INV-9003' };

// D19: jobs that will receive a part line priced at zero - the part was fitted
// and never costed, which is where margin quietly disappears.
Set<String> zeroPriceJobs = new Set<String>{
    'Burst flexible hose under kitchen sink, water through the cabinetry.',
    'Workshop drain backing up into the wash bay, cannot trade.',
    'No hot water, elderly tenant.',
    'New power and data to the sleep room.',
    'Replace end-of-life lobby package unit.',
    'Lobby aircon not cooling.'
};

// D20: decimal point dropped on the labour line - 4.0 hours keyed as 40.
Set<String> badQuantityJobs = new Set<String>{
    'Six-monthly service on four rooftop package units.',
    'Switchboard upgrade to RCBOs.'
};

Map<String, Decimal> labourRate = new Map<String, Decimal>{
    'Plumbing' => 132.00, 'Electrical' => 145.00, 'HVAC' => 152.00, 'Multi-trade' => 145.00
};

Map<String, String> partFor = new Map<String, String>{
    'Plumbing'   => 'Flexible hose set and tap seals',
    'Electrical' => 'RCBO and cable, supplied',
    'HVAC'       => 'Filters, contactor and refrigerant',
    'Multi-trade'=> 'Sundry materials'
};

List<Service_Job__c> closedJobs = [
    SELECT Id, Name, Service_Type__c, Job_Type__c, Status__c, Invoice_Number__c,
           Description__c, On_Site_Hours__c, Callout_Fee__c
    FROM Service_Job__c
    WHERE Status__c IN ('Completed', 'Invoiced')
    ORDER BY Name ASC
];

List<Job_Line_Item__c> lines = new List<Job_Line_Item__c>();
Integer skipped = 0, zeroPriced = 0, badQuantity = 0;

for (Service_Job__c j : closedJobs) {

    if (j.Invoice_Number__c != null && noLineInvoices.contains(j.Invoice_Number__c)) {
        skipped++;
        continue;                                   // D16
    }

    Decimal rate  = labourRate.get(j.Service_Type__c);
    Decimal hours = (j.On_Site_Hours__c != null && j.On_Site_Hours__c > 0) ? j.On_Site_Hours__c : 2.00;

    if (badQuantityJobs.contains(j.Description__c)) {
        hours = 40.00;                              // D20
        badQuantity++;
    }

    lines.add(new Job_Line_Item__c(
        Service_Job__c = j.Id, Line_Type__c = 'Labour',
        Description__c = 'On-site labour, ' + j.Service_Type__c.toLowerCase(),
        Quantity__c = hours.setScale(2), Unit_Price__c = rate, GST_Applicable__c = true));

    Boolean needsParts = j.Job_Type__c == 'Installation'
                      || j.Job_Type__c == 'Emergency Callout'
                      || j.Job_Type__c == 'Scheduled Maintenance';

    if (needsParts) {
        Decimal unitPrice = 184.50;
        if (zeroPriceJobs.contains(j.Description__c)) {
            unitPrice = 0;                          // D19
            zeroPriced++;
        } else if (j.Job_Type__c == 'Installation') {
            unitPrice = 1290.00;
        } else if (j.Job_Type__c == 'Scheduled Maintenance') {
            unitPrice = 96.40;
        }

        lines.add(new Job_Line_Item__c(
            Service_Job__c = j.Id, Line_Type__c = 'Part or Material',
            Description__c = partFor.get(j.Service_Type__c),
            Quantity__c = 1, Unit_Price__c = unitPrice, GST_Applicable__c = true,
            Part_Number__c = j.Service_Type__c.substring(0, 2).toUpperCase() + '-' + j.Name.right(4),
            Supplier__c = 'Reece Trade Supplies'));
    }

    if (j.Job_Type__c == 'Installation') {
        lines.add(new Job_Line_Item__c(
            Service_Job__c = j.Id, Line_Type__c = 'Disposal or Recycling',
            Description__c = 'Removal and disposal of decommissioned equipment',
            Quantity__c = 1, Unit_Price__c = 145.00, GST_Applicable__c = true));
    }
}

Database.SaveResult[] results = Database.insert(lines, false);
Integer ok = 0;
for (Database.SaveResult r : results) {
    if (r.isSuccess()) { ok++; } else { System.debug('LINE ITEM FAILED: ' + r.getErrors()); }
}

System.debug('Seed 04 complete. Closed jobs considered: ' + closedJobs.size()
             + ', jobs left without lines (D16): ' + skipped
             + ', zero-priced part lines (D19): ' + zeroPriced
             + ', implausible labour quantities (D20): ' + badQuantity
             + ', line items inserted: ' + ok + '/' + lines.size());
