/*
 * Meridian Field Services - seed data 02: the field roster.
 *
 * Run against a Developer Edition or scratch org ONLY, after 01.
 * Defect classes seeded by this script: D9, D10. See seed/README.md.
 *
 * Run:  sf apex run --file seed/02_technicians.apex --target-org meridian
 */

Date today = Date.today();

List<Technician__c> techs = new List<Technician__c>{

    // ---- clean records ------------------------------------------------------
    new Technician__c(Name = 'Warrick Delaney',
                      Trade__c = 'Plumbing', Employment_Type__c = 'Employee',
                      Licence_Number__c = 'PL-114872', Licence_Expiry__c = today.addMonths(19),
                      Mobile__c = '0412 660 118', Email__c = 'warrick.delaney@meridianfs.example',
                      Base_Suburb__c = 'Parramatta', Hourly_Charge_Rate__c = 132.00, Active__c = true),

    new Technician__c(Name = 'Priyanka Mehra',
                      Trade__c = 'Electrical', Employment_Type__c = 'Employee',
                      Licence_Number__c = 'EC-208913', Licence_Expiry__c = today.addMonths(26),
                      Mobile__c = '0433 907 221', Email__c = 'priyanka.mehra@meridianfs.example',
                      Base_Suburb__c = 'Chatswood', Hourly_Charge_Rate__c = 145.00, Active__c = true),

    new Technician__c(Name = 'Josip Vukovic',
                      Trade__c = 'HVAC;Plumbing', Employment_Type__c = 'Employee',
                      Licence_Number__c = 'AU-33017', Licence_Expiry__c = today.addMonths(14),
                      Mobile__c = '0418 224 706', Email__c = 'josip.vukovic@meridianfs.example',
                      Base_Suburb__c = 'Liverpool', Hourly_Charge_Rate__c = 152.00, Active__c = true),

    // Licence inside the 30-day warning window - drives the Phase 11 scheduled alert.
    new Technician__c(Name = 'Tane Ropata',
                      Trade__c = 'Plumbing', Employment_Type__c = 'Subcontractor',
                      Licence_Number__c = 'PL-097331', Licence_Expiry__c = today.addDays(12),
                      Mobile__c = '0427 118 553', Email__c = 'tane@ropataplumbing.example',
                      Base_Suburb__c = 'Penrith', Hourly_Charge_Rate__c = 128.00, Active__c = true),

    // ---- D9: licence data defects ------------------------------------------
    new Technician__c(Name = 'Fiona Kealy',                       // expired 3 months ago
                      Trade__c = 'Electrical;HVAC', Employment_Type__c = 'Employee',
                      Licence_Number__c = 'EC-176204', Licence_Expiry__c = today.addMonths(-3),
                      Mobile__c = '0402 771 986', Email__c = 'fiona.kealy@meridianfs.example',
                      Base_Suburb__c = 'Hornsby', Hourly_Charge_Rate__c = 145.00, Active__c = true),

    new Technician__c(Name = 'Mahesh Iyer',                       // expired 8 months ago
                      Trade__c = 'HVAC', Employment_Type__c = 'Subcontractor',
                      Licence_Number__c = 'AU-21884', Licence_Expiry__c = today.addMonths(-8),
                      Mobile__c = '0466 330 209', Email__c = 'mahesh@iyerclimate.example',
                      Base_Suburb__c = 'Bankstown', Hourly_Charge_Rate__c = 138.00, Active__c = true),

    new Technician__c(Name = 'Bryn Castellan',                    // no licence recorded at all
                      Trade__c = 'Plumbing', Employment_Type__c = 'Subcontractor',
                      Licence_Number__c = null, Licence_Expiry__c = null,
                      Mobile__c = '0455 812 447', Email__c = 'bryn@castellanplumbing.example',
                      Base_Suburb__c = 'Blacktown', Hourly_Charge_Rate__c = 125.00, Active__c = true),

    // ---- D10: off the roster, but script 03 still assigns future work -------
    new Technician__c(Name = 'Odette Marchetti',
                      Trade__c = 'Electrical', Employment_Type__c = 'Employee',
                      Licence_Number__c = 'EC-190557', Licence_Expiry__c = today.addMonths(9),
                      Mobile__c = '0410 552 663', Email__c = 'odette.marchetti@meridianfs.example',
                      Base_Suburb__c = 'Marrickville', Hourly_Charge_Rate__c = 145.00, Active__c = false)
};

Database.SaveResult[] results = Database.insert(techs, false);
Integer ok = 0;
for (Database.SaveResult r : results) {
    if (r.isSuccess()) { ok++; } else { System.debug('TECHNICIAN FAILED: ' + r.getErrors()); }
}

System.debug('Seed 02 complete. Technicians inserted: ' + ok + '/' + techs.size());
