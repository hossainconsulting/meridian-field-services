/*
 * Meridian Field Services - seed data 03: the job history.
 *
 * Run against a Developer Edition or scratch org ONLY, after 01 and 02.
 * Defect classes seeded by this script: D11-D18, D21. See seed/README.md.
 *
 * Defects overlap on purpose. Real spreadsheet-era data does not arrive with
 * one problem per row, and the Phase 6 cleanup needs to cope with a job that
 * is simultaneously unassigned, missing its suburb and missing its certificate.
 *
 * Run:  sf apex run --file seed/03_service_jobs.apex --target-org meridian
 */

Datetime n = Datetime.now();

Map<String, Id> a = new Map<String, Id>();
for (Account acc : [SELECT Id, Name FROM Account]) { a.put(acc.Name, acc.Id); }

Map<String, Id> t = new Map<String, Id>();
for (Technician__c tech : [SELECT Id, Name FROM Technician__c]) { t.put(tech.Name, tech.Id); }

Map<Id, Id> siteContact = new Map<Id, Id>();
for (Contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId != null ORDER BY CreatedDate ASC]) {
    if (!siteContact.containsKey(con.AccountId)) { siteContact.put(con.AccountId, con.Id); }
}

List<Service_Job__c> jobs = new List<Service_Job__c>();

// =============================================================================
// Clean history - jobs that closed the way they are supposed to.
// =============================================================================

jobs.add(new Service_Job__c(
    Account__c = a.get('Hollis Residence'), Site_Contact__c = siteContact.get(a.get('Hollis Residence')),
    Service_Type__c = 'Plumbing', Job_Type__c = 'Emergency Callout', Priority__c = 'P1 Emergency',
    Status__c = 'Invoiced', Assigned_Technician__c = t.get('Warrick Delaney'),
    Service_Street__c = '19 Cavendish Street', Service_Suburb__c = 'Stanmore',
    Service_State__c = 'NSW', Service_Postcode__c = '2048',
    Scheduled_Start__c = n.addDays(-41), Scheduled_End__c = n.addDays(-41).addHours(3),
    Actual_Start__c = n.addDays(-41).addMinutes(25), Actual_End__c = n.addDays(-41).addHours(2),
    Description__c = 'Burst flexible hose under kitchen sink, water through the cabinetry.',
    Work_Performed__c = 'Isolated supply, replaced both flexible hoses and mixer seals, dried and reset cabinet base.',
    Callout_Fee__c = 95, Customer_Signature_Captured__c = true, Invoice_Number__c = 'INV-10041'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Ashcombe Strata Management'), Site_Contact__c = siteContact.get(a.get('Ashcombe Strata Management')),
    Service_Type__c = 'Plumbing', Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard',
    Status__c = 'Invoiced', Assigned_Technician__c = t.get('Warrick Delaney'),
    Service_Street__c = '14 Marsden Street', Service_Suburb__c = 'Parramatta',
    Service_State__c = 'NSW', Service_Postcode__c = '2150',
    Scheduled_Start__c = n.addDays(-33), Scheduled_End__c = n.addDays(-33).addHours(4),
    Actual_Start__c = n.addDays(-33), Actual_End__c = n.addDays(-33).addHours(4),
    Description__c = 'Quarterly common-property plumbing inspection, 24 units.',
    Work_Performed__c = 'Inspected risers, tested pressure at levels 1, 3 and 5, cleared two floor wastes.',
    Callout_Fee__c = 0, Customer_Signature_Captured__c = true, Invoice_Number__c = 'INV-10042'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Quayside Dental Rooms'), Site_Contact__c = siteContact.get(a.get('Quayside Dental Rooms')),
    Service_Type__c = 'Electrical', Job_Type__c = 'Installation', Priority__c = 'P3 Standard',
    Status__c = 'Invoiced', Assigned_Technician__c = t.get('Priyanka Mehra'),
    Service_Street__c = '5 The Corso', Service_Suburb__c = 'Manly',
    Service_State__c = 'NSW', Service_Postcode__c = '2095',
    Scheduled_Start__c = n.addDays(-28), Scheduled_End__c = n.addDays(-28).addHours(6),
    Actual_Start__c = n.addDays(-28), Actual_End__c = n.addDays(-28).addHours(7),
    Description__c = 'Dedicated circuit required for new intraoral scanner in surgery 2.',
    Work_Performed__c = 'Installed 20A dedicated circuit from main board, new RCBO, tested and tagged.',
    Callout_Fee__c = 0, Compliance_Certificate_Number__c = 'CCEW-88214',
    Customer_Signature_Captured__c = true, Invoice_Number__c = 'INV-10043'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Tarrenford Aged Care'), Site_Contact__c = siteContact.get(a.get('Tarrenford Aged Care')),
    Service_Type__c = 'HVAC', Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard',
    Status__c = 'Invoiced', Assigned_Technician__c = t.get('Josip Vukovic'),
    Service_Street__c = '88 Speed Street', Service_Suburb__c = 'Liverpool',
    Service_State__c = 'NSW', Service_Postcode__c = '2170',
    Scheduled_Start__c = n.addDays(-25), Scheduled_End__c = n.addDays(-25).addHours(8),
    Actual_Start__c = n.addDays(-25), Actual_End__c = n.addDays(-25).addHours(8).addMinutes(30),
    Description__c = 'Six-monthly service on four rooftop package units.',
    Work_Performed__c = 'Cleaned coils and filters on all four units, replaced contactor on unit 3, logged refrigerant charge.',
    Callout_Fee__c = 0, Compliance_Certificate_Number__c = 'ARC-33901',
    Customer_Signature_Captured__c = true, Invoice_Number__c = 'INV-10044'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Nguyen Residence'), Site_Contact__c = siteContact.get(a.get('Nguyen Residence')),
    Service_Type__c = 'HVAC', Job_Type__c = 'Installation', Priority__c = 'P4 Planned',
    Status__c = 'Completed', Assigned_Technician__c = t.get('Josip Vukovic'),
    Service_Street__c = '77 Boundary Road', Service_Suburb__c = 'Auburn',
    Service_State__c = 'NSW', Service_Postcode__c = '2144',
    Scheduled_Start__c = n.addDays(-9), Scheduled_End__c = n.addDays(-9).addHours(6),
    Actual_Start__c = n.addDays(-9), Actual_End__c = n.addDays(-9).addHours(6),
    Description__c = 'Supply and install 7.1kW split system to main bedroom.',
    Work_Performed__c = 'Installed indoor and outdoor units, core drilled, ran drain to garden bed, commissioned and demonstrated.',
    Callout_Fee__c = 0, Compliance_Certificate_Number__c = 'ARC-33902',
    Customer_Signature_Captured__c = true));

jobs.add(new Service_Job__c(
    Account__c = a.get('Brightwater Childcare'), Site_Contact__c = siteContact.get(a.get('Brightwater Childcare')),
    Service_Type__c = 'Electrical', Job_Type__c = 'Quote or Inspection', Priority__c = 'P3 Standard',
    Status__c = 'Invoiced', Assigned_Technician__c = t.get('Priyanka Mehra'),
    Service_Street__c = '31 Rosebank Avenue', Service_Suburb__c = 'Epping',
    Service_State__c = 'NSW', Service_Postcode__c = '2121',
    Scheduled_Start__c = n.addDays(-21), Scheduled_End__c = n.addDays(-21).addHours(3),
    Actual_Start__c = n.addDays(-21), Actual_End__c = n.addDays(-21).addHours(2).addMinutes(45),
    Description__c = 'Annual test and tag plus switchboard condition report for licensing.',
    Work_Performed__c = 'Tested and tagged 62 appliances, four failures removed from service, switchboard report issued.',
    Callout_Fee__c = 0, Compliance_Certificate_Number__c = 'CCEW-88215',
    Customer_Signature_Captured__c = true, Invoice_Number__c = 'INV-10045'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Ferndale Motors'), Site_Contact__c = siteContact.get(a.get('Ferndale Motors')),
    Service_Type__c = 'Plumbing', Job_Type__c = 'Emergency Callout', Priority__c = 'P1 Emergency',
    Status__c = 'Invoiced', Assigned_Technician__c = t.get('Tane Ropata'),
    Service_Street__c = '145 Great Western Highway', Service_Suburb__c = 'Penrith',
    Service_State__c = 'NSW', Service_Postcode__c = '2750',
    Scheduled_Start__c = n.addDays(-17), Scheduled_End__c = n.addDays(-17).addHours(4),
    Actual_Start__c = n.addDays(-17).addMinutes(40), Actual_End__c = n.addDays(-17).addHours(3),
    Description__c = 'Workshop drain backing up into the wash bay, cannot trade.',
    Work_Performed__c = 'Jetted 18m of drain line, removed compacted sludge from the interceptor, CCTV confirmed clear.',
    Callout_Fee__c = 145, Customer_Signature_Captured__c = true, Invoice_Number__c = 'INV-10046'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Mallowfield Retirement Village'), Site_Contact__c = siteContact.get(a.get('Mallowfield Retirement Village')),
    Service_Type__c = 'Plumbing', Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard',
    Status__c = 'Completed', Assigned_Technician__c = t.get('Warrick Delaney'),
    Service_Street__c = '12 Peats Ferry Road', Service_Suburb__c = 'Hornsby',
    Service_State__c = 'NSW', Service_Postcode__c = '2077',
    Scheduled_Start__c = n.addDays(-6), Scheduled_End__c = n.addDays(-6).addHours(5),
    Actual_Start__c = n.addDays(-6), Actual_End__c = n.addDays(-6).addHours(5).addMinutes(20),
    Description__c = 'Thermostatic mixing valve service across 14 independent living units.',
    Work_Performed__c = 'Serviced and temperature-tested 14 TMVs, two replaced, all logged against unit numbers.',
    Callout_Fee__c = 0, Customer_Signature_Captured__c = true));

jobs.add(new Service_Job__c(
    Account__c = a.get('Rosecliff Gardens Body Corporate'), Site_Contact__c = siteContact.get(a.get('Rosecliff Gardens Body Corporate')),
    Service_Type__c = 'HVAC', Job_Type__c = 'Emergency Callout', Priority__c = 'P2 Urgent',
    Status__c = 'Invoiced', Assigned_Technician__c = t.get('Josip Vukovic'),
    Service_Street__c = '7 Kingsway', Service_Suburb__c = 'Cronulla',
    Service_State__c = 'NSW', Service_Postcode__c = '2230',
    Scheduled_Start__c = n.addDays(-13), Scheduled_End__c = n.addDays(-13).addHours(4),
    Actual_Start__c = n.addDays(-13).addHours(1), Actual_End__c = n.addDays(-13).addHours(4),
    Description__c = 'Lobby and gym air conditioning down, residents complaining to the committee.',
    Work_Performed__c = 'Replaced failed capacitor and cleaned condenser on the common-area unit, restored operation.',
    Callout_Fee__c = 145, Compliance_Certificate_Number__c = 'ARC-33903',
    Customer_Signature_Captured__c = true, Invoice_Number__c = 'INV-10047'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Ellersley Public Housing Trust'), Site_Contact__c = siteContact.get(a.get('Ellersley Public Housing Trust')),
    Service_Type__c = 'Plumbing', Job_Type__c = 'Warranty Return', Priority__c = 'P3 Standard',
    Status__c = 'Completed', Assigned_Technician__c = t.get('Tane Ropata'),
    Service_Street__c = '40 Restwell Street', Service_Suburb__c = 'Bankstown',
    Service_State__c = 'NSW', Service_Postcode__c = '2200',
    Scheduled_Start__c = n.addDays(-4), Scheduled_End__c = n.addDays(-4).addHours(2),
    Actual_Start__c = n.addDays(-4), Actual_End__c = n.addDays(-4).addHours(1).addMinutes(30),
    Description__c = 'Cistern installed last month is running intermittently. Return under warranty.',
    Work_Performed__c = 'Replaced faulty inlet valve under warranty, no charge to customer.',
    Callout_Fee__c = 0, Customer_Signature_Captured__c = true));

// =============================================================================
// Open work - the current schedule.
// =============================================================================

jobs.add(new Service_Job__c(
    Account__c = a.get('Verrall Property Group'), Site_Contact__c = siteContact.get(a.get('Verrall Property Group')),
    Service_Type__c = 'Electrical', Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard',
    Status__c = 'Scheduled', Assigned_Technician__c = t.get('Priyanka Mehra'),
    Service_Street__c = '61 Archer Street', Service_Suburb__c = 'Chatswood',
    Service_State__c = 'NSW', Service_Postcode__c = '2067',
    Scheduled_Start__c = n.addDays(3), Scheduled_End__c = n.addDays(3).addHours(3),
    Description__c = 'Smoke alarm compliance check before new tenancy, all four bedrooms.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Okafor Residence'), Site_Contact__c = siteContact.get(a.get('Okafor Residence')),
    Service_Type__c = 'Plumbing', Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard',
    Status__c = 'Scheduled', Assigned_Technician__c = t.get('Warrick Delaney'),
    Service_Street__c = '6 Wentworth Avenue', Service_Suburb__c = 'Blacktown',
    Service_State__c = 'NSW', Service_Postcode__c = '2148',
    Scheduled_Start__c = n.addDays(1), Scheduled_End__c = n.addDays(1).addHours(2),
    Description__c = 'Hot water unit is slow to recover. Customer asked for it to be looked at before winter.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Corbray Fitness Studio'), Site_Contact__c = siteContact.get(a.get('Corbray Fitness Studio')),
    Service_Type__c = 'HVAC', Job_Type__c = 'Installation', Priority__c = 'P4 Planned',
    Status__c = 'Scheduled', Assigned_Technician__c = t.get('Josip Vukovic'),
    Service_Street__c = '18 Oxford Street', Service_Suburb__c = 'Bondi Junction',
    Service_State__c = 'NSW', Service_Postcode__c = '2022',
    Scheduled_Start__c = n.addDays(9), Scheduled_End__c = n.addDays(9).addHours(9),
    Description__c = 'Add two ceiling cassettes to the weights room, existing system at capacity.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Whitlow Residence'), Site_Contact__c = siteContact.get(a.get('Whitlow Residence')),
    Service_Type__c = 'Electrical', Job_Type__c = 'Emergency Callout', Priority__c = 'P1 Emergency',
    Status__c = 'Dispatched', Assigned_Technician__c = t.get('Priyanka Mehra'),
    Service_Street__c = '52 Perouse Road', Service_Suburb__c = 'Randwick',
    Service_State__c = 'NSW', Service_Postcode__c = '2031',
    Scheduled_Start__c = n.addHours(2), Scheduled_End__c = n.addHours(5),
    Description__c = 'Half the house has no power, main switch will not stay on.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Ravensmill Legal'), Site_Contact__c = siteContact.get(a.get('Ravensmill Legal')),
    Service_Type__c = 'HVAC', Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard',
    Status__c = 'Scheduled', Assigned_Technician__c = t.get('Josip Vukovic'),
    Service_Street__c = '9 Hunter Street', Service_Suburb__c = 'Sydney',
    Service_State__c = 'NSW', Service_Postcode__c = '2000',
    Scheduled_Start__c = n.addDays(6), Scheduled_End__c = n.addDays(6).addHours(4),
    Description__c = 'Quarterly filter change and BMS check, level 4 tenancy.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Petrakis Residence'), Site_Contact__c = siteContact.get(a.get('Petrakis Residence')),
    Service_Type__c = 'Plumbing', Job_Type__c = 'Emergency Callout', Priority__c = 'P2 Urgent',
    Status__c = 'In Progress', Assigned_Technician__c = t.get('Tane Ropata'),
    Service_Street__c = '3 Frazer Street', Service_Suburb__c = 'Marrickville',
    Service_State__c = 'NSW', Service_Postcode__c = '2204',
    Scheduled_Start__c = n.addHours(-2), Scheduled_End__c = n.addHours(2),
    Actual_Start__c = n.addHours(-1),
    Description__c = 'Toilet overflowing into the hallway, water isolated at the meter.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Ashcombe Strata Management'), Site_Contact__c = siteContact.get(a.get('Ashcombe Strata Management')),
    Service_Type__c = 'Plumbing', Job_Type__c = 'Quote or Inspection', Priority__c = 'P3 Standard',
    Status__c = 'Draft',
    Service_Street__c = '14 Marsden Street', Service_Suburb__c = 'Parramatta',
    Service_State__c = 'NSW', Service_Postcode__c = '2150',
    Description__c = 'Committee has asked for a quote to replace the level 1 riser. Awaiting scope confirmation.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Mallowfield Retirement Village'), Site_Contact__c = siteContact.get(a.get('Mallowfield Retirement Village')),
    Service_Type__c = 'HVAC', Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P4 Planned',
    Status__c = 'Scheduled', Assigned_Technician__c = t.get('Josip Vukovic'),
    Service_Street__c = '12 Peats Ferry Road', Service_Suburb__c = 'Hornsby',
    Service_State__c = 'NSW', Service_Postcode__c = '2077',
    Scheduled_Start__c = n.addDays(14), Scheduled_End__c = n.addDays(14).addHours(7),
    Description__c = 'Pre-summer service on all 14 independent living unit split systems.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Delmont Bakehouse'), Site_Contact__c = siteContact.get(a.get('Delmont Bakehouse')),
    Service_Type__c = 'Plumbing', Job_Type__c = 'Emergency Callout', Priority__c = 'P2 Urgent',
    Status__c = 'Cancelled',
    Service_Street__c = '203 King Street', Service_Suburb__c = 'Newtown',
    Service_State__c = 'NSW', Service_Postcode__c = '2042',
    Scheduled_Start__c = n.addDays(-2), Scheduled_End__c = n.addDays(-2).addHours(3),
    Description__c = 'Reported leak at the proving room sink. Customer called back, their own handyman fixed it.'));

// =============================================================================
// Deliberate defects. Every block below is a known problem carried over from
// the spreadsheet era. Phase 5 stops new ones; Phase 6 cleans these up.
// =============================================================================

// ---- D11: scheduled window ends before it starts ---------------------------
jobs.add(new Service_Job__c(
    Account__c = a.get('Verrall Property Group'), Service_Type__c = 'Plumbing',
    Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard', Status__c = 'Scheduled',
    Assigned_Technician__c = t.get('Warrick Delaney'),
    Service_Street__c = '8 Nelson Street', Service_Suburb__c = 'Chatswood',
    Service_State__c = 'NSW', Service_Postcode__c = '2067',
    Scheduled_Start__c = n.addDays(5).addHours(4), Scheduled_End__c = n.addDays(5),
    Description__c = 'Tap washers throughout, vacant property.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Ferndale Motors'), Service_Type__c = 'Electrical',
    Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard', Status__c = 'Scheduled',
    Assigned_Technician__c = t.get('Warrick Delaney'),          // D21: plumber on an electrical job
    Service_Street__c = '145 Great Western Highway',            // D17: no suburb, no postcode
    Service_State__c = 'NSW',
    Scheduled_Start__c = n.addDays(8).addHours(6), Scheduled_End__c = n.addDays(8).addHours(1),
    Description__c = 'Test and tag workshop hand tools.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Corbray Fitness Studio'), Service_Type__c = 'HVAC',
    Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P4 Planned', Status__c = 'Scheduled',
    Assigned_Technician__c = t.get('Mahesh Iyer'),
    Service_Street__c = '18 Oxford Street',                     // D17
    Service_State__c = 'NSW',
    Scheduled_Start__c = n.addDays(11).addHours(8), Scheduled_End__c = n.addDays(11).addHours(2),
    Description__c = 'Filter change, studio 2.'));

// ---- D12: work finished before it started ----------------------------------
jobs.add(new Service_Job__c(
    Account__c = a.get('Hollis Residence'), Service_Type__c = 'Plumbing',
    Job_Type__c = 'Emergency Callout', Priority__c = 'P2 Urgent', Status__c = 'Completed',
    Assigned_Technician__c = t.get('Tane Ropata'),
    Service_Street__c = '19 Cavendish Street', Service_Suburb__c = 'Stanmore',
    Service_State__c = 'NSW', Service_Postcode__c = '2048',
    Scheduled_Start__c = n.addDays(-19), Scheduled_End__c = n.addDays(-19).addHours(3),
    Actual_Start__c = n.addDays(-19).addHours(3), Actual_End__c = n.addDays(-19).addHours(1),
    Description__c = 'Leaking laundry tap.', Work_Performed__c = 'Replaced tap set.',
    Callout_Fee__c = 95, Customer_Signature_Captured__c = true));

jobs.add(new Service_Job__c(
    Account__c = a.get('Quayside Dental Rooms'), Service_Type__c = 'HVAC',
    Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard', Status__c = 'Completed',
    Assigned_Technician__c = t.get('Josip Vukovic'),
    Service_Street__c = '5 The Corso',                          // D17
    Service_State__c = 'NSW',
    Scheduled_Start__c = n.addDays(-15), Scheduled_End__c = n.addDays(-15).addHours(2),
    Actual_Start__c = n.addDays(-15).addHours(2), Actual_End__c = n.addDays(-15),
    Description__c = 'Split system service, reception.', Work_Performed__c = 'Cleaned filters and coil.',
    Compliance_Certificate_Number__c = 'ARC-33904', Customer_Signature_Captured__c = true));

// ---- D13: completed with nobody recorded as having attended ----------------
jobs.add(new Service_Job__c(
    Account__c = a.get('Ellersley Public Housing Trust'), Service_Type__c = 'Plumbing',
    Job_Type__c = 'Emergency Callout', Priority__c = 'P1 Emergency', Status__c = 'Completed',
    Service_Street__c = '12 Restwell Street', Service_Suburb__c = 'Bankstown',
    Service_State__c = 'NSW', Service_Postcode__c = '2200',
    Scheduled_Start__c = n.addDays(-52), Scheduled_End__c = n.addDays(-52).addHours(4),
    Actual_Start__c = n.addDays(-52), Actual_End__c = n.addDays(-52).addHours(3),
    Description__c = 'No hot water, elderly tenant.', Work_Performed__c = 'Replaced element and thermostat.',
    Callout_Fee__c = 95));

jobs.add(new Service_Job__c(
    Account__c = a.get('Ellersley Public Housing Trust'), Service_Type__c = 'Plumbing',
    Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard', Status__c = 'Completed',
    Service_Street__c = '18 Restwell Street',                   // D17
    Service_State__c = 'NSW',
    Scheduled_Start__c = n.addDays(-48), Scheduled_End__c = n.addDays(-48).addHours(2),
    Actual_End__c = n.addDays(-48).addHours(2),
    Description__c = 'Annual backflow test.', Work_Performed__c = 'Tested, passed.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Ashcombe Strata Mgmt Pty Ltd'), Service_Type__c = 'Plumbing',
    Job_Type__c = 'Emergency Callout', Priority__c = 'P2 Urgent', Status__c = 'Completed',
    Service_Street__c = '14 Marsden Street', Service_Suburb__c = 'Parramatta',
    Service_State__c = 'NSW', Service_Postcode__c = '2150',
    Scheduled_Start__c = n.addDays(-44), Scheduled_End__c = n.addDays(-44).addHours(3),
    Description__c = 'Carpark drain blocked after storm.', Work_Performed__c = 'Cleared drain, no parts.',
    Callout_Fee__c = 145));

jobs.add(new Service_Job__c(
    Account__c = a.get('Mallowfield Retirement Village'), Service_Type__c = 'Plumbing',
    Job_Type__c = 'Warranty Return', Priority__c = 'P3 Standard', Status__c = 'Completed',
    Service_Street__c = '12 Peats Ferry Road', Service_Suburb__c = 'Hornsby',
    Service_State__c = 'NSW', Service_Postcode__c = '2077',
    Scheduled_Start__c = n.addDays(-37), Scheduled_End__c = n.addDays(-37).addHours(1),
    Actual_Start__c = n.addDays(-37), Actual_End__c = n.addDays(-37).addMinutes(45),
    Description__c = 'TMV replaced last visit is over temperature.', Work_Performed__c = 'Recalibrated, no charge.'));

// ---- D14: completed certificate-bearing work with no certificate number ----
jobs.add(new Service_Job__c(
    Account__c = a.get('Brightwater Childcare'), Service_Type__c = 'Electrical',
    Job_Type__c = 'Installation', Priority__c = 'P3 Standard', Status__c = 'Invoiced',
    Assigned_Technician__c = t.get('Fiona Kealy'),
    Service_Street__c = '31 Rosebank Avenue', Service_Suburb__c = 'Epping',
    Service_State__c = 'NSW', Service_Postcode__c = '2121',
    Scheduled_Start__c = n.addDays(-63), Scheduled_End__c = n.addDays(-63).addHours(5),
    Actual_Start__c = n.addDays(-63), Actual_End__c = n.addDays(-63).addHours(5),
    Description__c = 'New power and data to the sleep room.',
    Work_Performed__c = 'Installed four GPOs and two data points, made good.',
    Customer_Signature_Captured__c = true, Invoice_Number__c = 'INV-10031'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Tarrenford Aged Care'), Service_Type__c = 'Electrical',
    Job_Type__c = 'Emergency Callout', Priority__c = 'P1 Emergency', Status__c = 'Completed',
    Assigned_Technician__c = t.get('Fiona Kealy'),
    Service_Street__c = '88 Speed Street', Service_Suburb__c = 'Liverpool',
    Service_State__c = 'NSW', Service_Postcode__c = '2170',
    Scheduled_Start__c = n.addDays(-58), Scheduled_End__c = n.addDays(-58).addHours(4),
    Actual_Start__c = n.addDays(-58), Actual_End__c = n.addDays(-58).addHours(4),
    Description__c = 'Nurse call system lost power overnight.',
    Work_Performed__c = 'Replaced failed sub-board breaker, restored supply, tested nurse call.',
    Callout_Fee__c = 145, Customer_Signature_Captured__c = true));

jobs.add(new Service_Job__c(
    Account__c = a.get('Rosecliff Gardens Body Corporate'), Service_Type__c = 'HVAC',
    Job_Type__c = 'Installation', Priority__c = 'P4 Planned', Status__c = 'Invoiced',
    Assigned_Technician__c = t.get('Mahesh Iyer'),
    Service_Street__c = '7 Kingsway',                           // D17
    Service_State__c = 'NSW',
    Scheduled_Start__c = n.addDays(-71), Scheduled_End__c = n.addDays(-71).addHours(8),
    Actual_Start__c = n.addDays(-71), Actual_End__c = n.addDays(-71).addHours(9),
    Description__c = 'Replace end-of-life lobby package unit.',
    Work_Performed__c = 'Removed old unit, craned in replacement, commissioned.',
    Customer_Signature_Captured__c = true, Invoice_Number__c = 'INV-10028'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Nguyen Residence'), Service_Type__c = 'Electrical',
    Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard', Status__c = 'Completed',
    Assigned_Technician__c = t.get('Priyanka Mehra'),
    Service_Street__c = '77 Boundary Road', Service_Suburb__c = 'Auburn',
    Service_State__c = 'NSW', Service_Postcode__c = '2144',
    Scheduled_Start__c = n.addDays(-30), Scheduled_End__c = n.addDays(-30).addHours(2),
    Actual_Start__c = n.addDays(-30), Actual_End__c = n.addDays(-30).addHours(2),
    Description__c = 'Switchboard upgrade to RCBOs.',
    Work_Performed__c = 'Replaced six fuses with RCBOs, tested all circuits.',
    Customer_Signature_Captured__c = true));

jobs.add(new Service_Job__c(
    Account__c = a.get('Ferndale Motors'), Service_Type__c = 'HVAC',
    Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard', Status__c = 'Completed',
    Assigned_Technician__c = t.get('Josip Vukovic'),
    Service_Street__c = '145 Great Western Highway', Service_Suburb__c = 'Penrith',
    Service_State__c = 'NSW', Service_Postcode__c = '2750',
    Scheduled_Start__c = n.addDays(-26), Scheduled_End__c = n.addDays(-26).addHours(3),
    Actual_Start__c = n.addDays(-26), Actual_End__c = n.addDays(-26).addHours(3),
    Description__c = 'Showroom air conditioning service.',
    Work_Performed__c = 'Serviced two ducted units, replaced return air filters.',
    Customer_Signature_Captured__c = true));

// ---- D15: abandoned mid-job, still sitting In Progress ---------------------
jobs.add(new Service_Job__c(
    Account__c = a.get('Delmont Bakehouse'), Service_Type__c = 'Plumbing',
    Job_Type__c = 'Emergency Callout', Priority__c = 'P2 Urgent', Status__c = 'In Progress',
    Assigned_Technician__c = t.get('Bryn Castellan'),
    Service_Street__c = '203 King Street', Service_Suburb__c = 'Newtown',
    Service_State__c = 'NSW', Service_Postcode__c = '2042',
    Scheduled_Start__c = n.addDays(-96), Scheduled_End__c = n.addDays(-96).addHours(4),
    Actual_Start__c = n.addDays(-96),
    Description__c = 'Grease trap overflowing.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Corbray Fitness Studio'), Service_Type__c = 'HVAC',
    Job_Type__c = 'Emergency Callout', Priority__c = 'P2 Urgent', Status__c = 'In Progress',
    Assigned_Technician__c = t.get('Mahesh Iyer'),
    Service_Street__c = '18 Oxford Street', Service_Suburb__c = 'Bondi Junction',
    Service_State__c = 'NSW', Service_Postcode__c = '2022',
    Scheduled_Start__c = n.addDays(-88), Scheduled_End__c = n.addDays(-88).addHours(3),
    Actual_Start__c = n.addDays(-88),
    Description__c = 'Studio 1 unit blowing warm air.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Ravensmill Legal'), Service_Type__c = 'Electrical',
    Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard', Status__c = 'In Progress',
    Assigned_Technician__c = t.get('Warrick Delaney'),          // D21: plumber on an electrical job
    Service_Street__c = '9 Hunter Street',                      // D17
    Service_State__c = 'NSW',
    Scheduled_Start__c = n.addDays(-77), Scheduled_End__c = n.addDays(-77).addHours(6),
    Actual_Start__c = n.addDays(-77),
    Description__c = 'Emergency lighting compliance test, whole floor.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Petrakis Residence'), Service_Type__c = 'Plumbing',
    Job_Type__c = 'Quote or Inspection', Priority__c = 'P3 Standard', Status__c = 'In Progress',
    Assigned_Technician__c = t.get('Bryn Castellan'),
    Service_Street__c = '3 Frazer Street', Service_Suburb__c = 'Marrickville',
    Service_State__c = 'NSW', Service_Postcode__c = '2204',
    Scheduled_Start__c = n.addDays(-69), Scheduled_End__c = n.addDays(-69).addHours(2),
    Actual_Start__c = n.addDays(-69),
    Description__c = 'Quote to re-pipe the bathroom.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Verrall Property Group'), Service_Type__c = 'HVAC',
    Job_Type__c = 'Warranty Return', Priority__c = 'P3 Standard', Status__c = 'In Progress',
    Assigned_Technician__c = t.get('Priyanka Mehra'),           // D21: electrician on an HVAC job
    Service_Street__c = '61 Archer Street', Service_Suburb__c = 'Chatswood',
    Service_State__c = 'NSW', Service_Postcode__c = '2067',
    Scheduled_Start__c = n.addDays(-61), Scheduled_End__c = n.addDays(-61).addHours(2),
    Actual_Start__c = n.addDays(-61),
    Description__c = 'Unit installed in March is icing up. Tenant chasing.'));

// ---- D16: invoiced with nothing to invoice (script 04 skips these) ---------
jobs.add(new Service_Job__c(
    Account__c = a.get('TARRENFORD AGED CARE'), Service_Type__c = 'Plumbing',
    Job_Type__c = 'Emergency Callout', Priority__c = 'P1 Emergency', Status__c = 'Invoiced',
    Assigned_Technician__c = t.get('Warrick Delaney'),
    Service_Street__c = '88 Speed Street', Service_Suburb__c = 'Liverpool',
    Service_State__c = 'NSW', Service_Postcode__c = '2170',
    Scheduled_Start__c = n.addDays(-35), Scheduled_End__c = n.addDays(-35).addHours(3),
    Actual_Start__c = n.addDays(-35), Actual_End__c = n.addDays(-35).addHours(2),
    Description__c = 'Blocked toilet, wing B.', Work_Performed__c = 'Cleared blockage.',
    Customer_Signature_Captured__c = true, Invoice_Number__c = 'INV-9001'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Okafor Residence'), Service_Type__c = 'Plumbing',
    Job_Type__c = 'Emergency Callout', Priority__c = 'P2 Urgent', Status__c = 'Invoiced',
    Assigned_Technician__c = t.get('Tane Ropata'),
    Service_Street__c = '6 Wentworth Avenue',                   // D17
    Service_State__c = 'NSW',
    Scheduled_Start__c = n.addDays(-24), Scheduled_End__c = n.addDays(-24).addHours(2),
    Actual_Start__c = n.addDays(-24), Actual_End__c = n.addDays(-24).addHours(1),
    Description__c = 'Leaking gutter downpipe into the wall.', Work_Performed__c = 'Resealed downpipe joint.',
    Invoice_Number__c = 'INV-9002'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Ravensmill Legal'), Service_Type__c = 'HVAC',
    Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard', Status__c = 'Invoiced',
    Assigned_Technician__c = t.get('Josip Vukovic'),
    Service_Street__c = '9 Hunter Street', Service_Suburb__c = 'Sydney',
    Service_State__c = 'NSW', Service_Postcode__c = '2000',
    Scheduled_Start__c = n.addDays(-20), Scheduled_End__c = n.addDays(-20).addHours(3),
    Actual_Start__c = n.addDays(-20), Actual_End__c = n.addDays(-20).addHours(3),
    Description__c = 'Filter change, level 4.', Work_Performed__c = 'Filters replaced.',
    Compliance_Certificate_Number__c = 'ARC-33905', Customer_Signature_Captured__c = true,
    Invoice_Number__c = 'INV-9003'));

// ---- D10: work assigned to a technician who is off the roster -------------
jobs.add(new Service_Job__c(
    Account__c = a.get('Brightwater Childcare'), Service_Type__c = 'Electrical',
    Job_Type__c = 'Scheduled Maintenance', Priority__c = 'P3 Standard', Status__c = 'Scheduled',
    Assigned_Technician__c = t.get('Odette Marchetti'),
    Service_Street__c = '31 Rosebank Avenue', Service_Suburb__c = 'Epping',
    Service_State__c = 'NSW', Service_Postcode__c = '2121',
    Scheduled_Start__c = n.addDays(4), Scheduled_End__c = n.addDays(4).addHours(3),
    Description__c = 'Replace failed emergency exit light, main hall.'));

jobs.add(new Service_Job__c(
    Account__c = a.get('Whitlow Residence'), Service_Type__c = 'Electrical',
    Job_Type__c = 'Quote or Inspection', Priority__c = 'P4 Planned', Status__c = 'Scheduled',
    Assigned_Technician__c = t.get('Odette Marchetti'),
    Service_Street__c = '52 Perouse Road', Service_Suburb__c = 'Randwick',
    Service_State__c = 'NSW', Service_Postcode__c = '2031',
    Scheduled_Start__c = n.addDays(7), Scheduled_End__c = n.addDays(7).addHours(2),
    Description__c = 'Quote for solar-ready switchboard upgrade.'));

// ---- D18: the same job logged twice, a day apart ---------------------------
jobs.add(new Service_Job__c(
    Account__c = a.get('Ashcombe Strata Management'), Service_Type__c = 'HVAC',
    Job_Type__c = 'Emergency Callout', Priority__c = 'P2 Urgent', Status__c = 'Completed',
    Assigned_Technician__c = t.get('Josip Vukovic'),
    Service_Street__c = '14 Marsden Street', Service_Suburb__c = 'Parramatta',
    Service_State__c = 'NSW', Service_Postcode__c = '2150',
    Scheduled_Start__c = n.addDays(-12), Scheduled_End__c = n.addDays(-12).addHours(3),
    Actual_Start__c = n.addDays(-12), Actual_End__c = n.addDays(-12).addHours(2),
    Description__c = 'Lobby aircon not cooling.', Work_Performed__c = 'Regassed and leak tested.',
    Compliance_Certificate_Number__c = 'ARC-33906', Callout_Fee__c = 145));

jobs.add(new Service_Job__c(
    Account__c = a.get('Ashcombe Strata Mgmt Pty Ltd'),         // logged again against the duplicate account
    Service_Type__c = 'HVAC', Job_Type__c = 'Emergency Callout', Priority__c = 'P2 Urgent',
    Status__c = 'Completed', Assigned_Technician__c = t.get('Josip Vukovic'),
    Service_Street__c = '14 Marsden St', Service_Suburb__c = 'Parramatta',
    Service_State__c = 'NSW', Service_Postcode__c = '2150',
    Scheduled_Start__c = n.addDays(-11), Scheduled_End__c = n.addDays(-11).addHours(3),
    Actual_Start__c = n.addDays(-11), Actual_End__c = n.addDays(-11).addHours(2),
    Description__c = 'Lobby air conditioning not cooling', Work_Performed__c = 'Regas and leak test.',
    Callout_Fee__c = 145));

jobs.add(new Service_Job__c(
    Account__c = a.get('Delmont Bakehouse'), Service_Type__c = 'Electrical',
    Job_Type__c = 'Emergency Callout', Priority__c = 'P1 Emergency', Status__c = 'Completed',
    Assigned_Technician__c = t.get('Priyanka Mehra'),
    Service_Street__c = '203 King Street', Service_Suburb__c = 'Newtown',
    Service_State__c = 'NSW', Service_Postcode__c = '2042',
    Scheduled_Start__c = n.addDays(-7), Scheduled_End__c = n.addDays(-7).addHours(3),
    Actual_Start__c = n.addDays(-7), Actual_End__c = n.addDays(-7).addHours(2),
    Description__c = 'Oven circuit tripping, cannot bake.',
    Work_Performed__c = 'Replaced damaged oven element flex and RCBO.',
    Compliance_Certificate_Number__c = 'CCEW-88216', Callout_Fee__c = 145));

jobs.add(new Service_Job__c(
    Account__c = a.get('Delmont Bakehouse'), Service_Type__c = 'Electrical',
    Job_Type__c = 'Emergency Callout', Priority__c = 'P1 Emergency', Status__c = 'Completed',
    Assigned_Technician__c = t.get('Priyanka Mehra'),
    Service_Street__c = '203 King St', Service_Suburb__c = 'Newtown',
    Service_State__c = 'NSW', Service_Postcode__c = '2042',
    Scheduled_Start__c = n.addDays(-7).addHours(1), Scheduled_End__c = n.addDays(-7).addHours(4),
    Actual_Start__c = n.addDays(-7).addHours(1), Actual_End__c = n.addDays(-7).addHours(3),
    Description__c = 'oven tripping breaker', Work_Performed__c = 'Replaced flex and breaker.',
    Callout_Fee__c = 145));

// =============================================================================

Database.SaveResult[] results = Database.insert(jobs, false);
Integer ok = 0;
for (Database.SaveResult r : results) {
    if (r.isSuccess()) { ok++; } else { System.debug('JOB FAILED: ' + r.getErrors()); }
}

System.debug('Seed 03 complete. Service jobs inserted: ' + ok + '/' + jobs.size());
