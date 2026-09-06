/*
 * Meridian Field Services - seed data 01: customers and site contacts.
 *
 * Run against a Developer Edition or scratch org ONLY. This script deliberately
 * loads defective data: duplicate customers, inconsistent phone and state
 * formats, missing postcodes and malformed email addresses. Those defects are
 * the raw material for the Phase 5 (validation and duplicate rules) and
 * Phase 6 (cleanup and migration) work. Do not "fix" them here.
 *
 * Defect classes seeded by this script: D1-D8. See seed/README.md.
 *
 * Run:  sf apex run --file seed/01_accounts_contacts.apex --target-org meridian
 */

List<Account> accounts = new List<Account>{

    // ---- clean records ------------------------------------------------------
    new Account(Name = 'Ashcombe Strata Management',
                Phone = '(02) 9635 4180',
                BillingStreet = '14 Marsden Street', BillingCity = 'Parramatta',
                BillingState = 'NSW', BillingPostalCode = '2150', BillingCountry = 'Australia',
                Customer_Type__c = 'Strata or Body Corporate',
                Site_Access_Notes__c = 'Building manager holds all keys. Contact before 3pm weekdays.'),

    new Account(Name = 'Verrall Property Group',
                Phone = '(02) 9412 7733',
                BillingStreet = '2 Endeavour Street', BillingCity = 'Chatswood',
                BillingState = 'NSW', BillingPostalCode = '2067', BillingCountry = 'Australia',
                Customer_Type__c = 'Real Estate Agent',
                Site_Access_Notes__c = 'Tenanted properties. Always give 24 hours notice.'),

    new Account(Name = 'Tarrenford Aged Care',
                Phone = '(02) 9601 2244',
                BillingStreet = '88 Speed Street', BillingCity = 'Liverpool',
                BillingState = 'NSW', BillingPostalCode = '2170', BillingCountry = 'Australia',
                Customer_Type__c = 'Commercial',
                Site_Access_Notes__c = 'Sign in at reception. Police check required on file.'),

    new Account(Name = 'Quayside Dental Rooms',
                Phone = '(02) 9977 3120',
                BillingStreet = '5 The Corso', BillingCity = 'Manly',
                BillingState = 'NSW', BillingPostalCode = '2095', BillingCountry = 'Australia',
                Customer_Type__c = 'Commercial',
                Site_Access_Notes__c = 'No noisy work between 9am and 5pm. After-hours preferred.'),

    new Account(Name = 'Brightwater Childcare',
                Phone = '(02) 9899 6041',
                BillingStreet = '31 Rosebank Avenue', BillingCity = 'Epping',
                BillingState = 'NSW', BillingPostalCode = '2121', BillingCountry = 'Australia',
                Customer_Type__c = 'Commercial',
                Site_Access_Notes__c = 'Working with Children Check mandatory. Access only after 6pm.'),

    new Account(Name = 'Rosecliff Gardens Body Corporate',
                Phone = '(02) 9523 8890',
                BillingStreet = '7 Kingsway', BillingCity = 'Cronulla',
                BillingState = 'NSW', BillingPostalCode = '2230', BillingCountry = 'Australia',
                Customer_Type__c = 'Strata or Body Corporate',
                Site_Access_Notes__c = 'Basement plant room. Fob from unit 12.'),

    new Account(Name = 'Ellersley Public Housing Trust',
                Phone = '(02) 9707 1500',
                BillingStreet = '40 Restwell Street', BillingCity = 'Bankstown',
                BillingState = 'NSW', BillingPostalCode = '2200', BillingCountry = 'Australia',
                Customer_Type__c = 'Government',
                Site_Access_Notes__c = 'Purchase order required before attendance. No exceptions.'),

    new Account(Name = 'Mallowfield Retirement Village',
                Phone = '(02) 9847 2210',
                BillingStreet = '12 Peats Ferry Road', BillingCity = 'Hornsby',
                BillingState = 'NSW', BillingPostalCode = '2077', BillingCountry = 'Australia',
                Customer_Type__c = 'Commercial',
                Site_Access_Notes__c = 'Residents on site. Announce yourself at each unit.'),

    // ---- D1: duplicate customers, near-match names --------------------------
    new Account(Name = 'Ashcombe Strata Mgmt Pty Ltd',          // dupe of Ashcombe Strata Management
                Phone = '0296354180',                           // D2: unformatted
                BillingStreet = 'Level 2, 14 Marsden St', BillingCity = 'Parramatta',
                BillingState = 'New South Wales',               // D4: state as full name
                BillingPostalCode = '2150', BillingCountry = 'Australia',
                Customer_Type__c = 'Strata or Body Corporate'),

    new Account(Name = 'TARRENFORD AGED CARE',                  // D1 + D5: dupe, all caps
                Phone = '+61 2 9601 2244',                      // D2: international format
                BillingStreet = '88 Speed St', BillingCity = 'Liverpool',
                BillingState = 'nsw',                           // D4: lower case
                BillingPostalCode = null,                       // D3: missing postcode
                BillingCountry = 'Australia'),                  // D6: no customer type

    new Account(Name = 'Delmont Bakehouse',
                Phone = '02 9564 3311',
                BillingStreet = '203 King Street', BillingCity = 'Newtown',
                BillingState = 'NSW', BillingPostalCode = '2042', BillingCountry = 'Australia',
                Customer_Type__c = 'Commercial'),

    new Account(Name = 'Delmont Bakehouse ',                    // D1 + D5: dupe, trailing space
                Phone = '0295643311',                           // D2
                BillingStreet = '203 King St', BillingCity = 'Newtown',
                BillingState = 'N.S.W.',                        // D4: punctuated
                BillingPostalCode = null,                       // D3
                BillingCountry = 'Australia'),                  // D6

    // ---- residential customers, assorted defects ---------------------------
    new Account(Name = 'Hollis Residence',
                Phone = '0412 345 678',                         // D2: mobile with spaces
                BillingStreet = '19 Cavendish Street', BillingCity = 'Stanmore',
                BillingState = 'NSW', BillingPostalCode = '2048', BillingCountry = 'Australia',
                Customer_Type__c = 'Residential'),

    new Account(Name = 'Okafor Residence',
                Phone = '0403-118-902',                         // D2: hyphenated
                BillingStreet = '6 Wentworth Avenue', BillingCity = 'Blacktown',
                BillingState = 'NSW', BillingPostalCode = null, // D3
                BillingCountry = 'Australia',
                Customer_Type__c = 'Residential'),

    new Account(Name = 'Nguyen Residence',
                Phone = '+61438772104',                         // D2: no separators
                BillingStreet = '77 Boundary Road', BillingCity = 'Auburn',
                BillingState = 'NSW', BillingPostalCode = '2144', BillingCountry = 'Australia',
                Customer_Type__c = 'Residential'),

    new Account(Name = 'Petrakis Residence',
                Phone = '9713 4402',                            // D2: no area code
                BillingStreet = '3 Frazer Street', BillingCity = 'Marrickville',
                BillingState = 'NSW', BillingPostalCode = null, // D3
                BillingCountry = 'Australia'),                  // D6

    new Account(Name = 'Whitlow Residence',
                Phone = null,                                   // D2: no phone at all
                BillingStreet = '52 Perouse Road', BillingCity = 'Randwick',
                BillingState = 'NSW', BillingPostalCode = '2031', BillingCountry = 'Australia',
                Customer_Type__c = 'Residential'),

    new Account(Name = 'Ferndale Motors',
                Phone = '(02)9622-7788',                        // D2: mixed separators
                BillingStreet = '145 Great Western Highway', BillingCity = 'Penrith',
                BillingState = 'NSW', BillingPostalCode = '2750', BillingCountry = 'Australia',
                Customer_Type__c = 'Commercial'),

    new Account(Name = 'Ravensmill Legal',
                Phone = '02 9264 0091',
                BillingStreet = '9 Hunter Street', BillingCity = 'Sydney',
                BillingState = 'NSW', BillingPostalCode = null, // D3
                BillingCountry = 'Australia',
                Customer_Type__c = 'Commercial'),

    new Account(Name = 'Corbray Fitness Studio',
                Phone = '0448 990 217',
                BillingStreet = '18 Oxford Street', BillingCity = 'Bondi Junction',
                BillingState = 'NSW', BillingPostalCode = '2022', BillingCountry = 'Australia',
                Customer_Type__c = null)                        // D6
};

Database.SaveResult[] acctResults = Database.insert(accounts, false);
Integer acctOk = 0;
for (Database.SaveResult r : acctResults) {
    if (r.isSuccess()) { acctOk++; } else { System.debug('ACCOUNT FAILED: ' + r.getErrors()); }
}

Map<String, Id> byName = new Map<String, Id>();
for (Account a : accounts) { byName.put(a.Name, a.Id); }

List<Contact> contacts = new List<Contact>{

    // ---- clean records ------------------------------------------------------
    new Contact(FirstName = 'Marguerite', LastName = 'Ashcombe', AccountId = byName.get('Ashcombe Strata Management'),
                Title = 'Building Manager', Email = 'm.ashcombe@ashcombestrata.example',
                Phone = '(02) 9635 4180', MobilePhone = '0417 220 118'),
    new Contact(FirstName = 'Devan', LastName = 'Verrall', AccountId = byName.get('Verrall Property Group'),
                Title = 'Property Manager', Email = 'devan@verrallproperty.example',
                Phone = '(02) 9412 7733', MobilePhone = '0431 887 004'),
    new Contact(FirstName = 'Priya', LastName = 'Raghunathan', AccountId = byName.get('Tarrenford Aged Care'),
                Title = 'Facilities Coordinator', Email = 'p.raghunathan@tarrenford.example',
                Phone = '(02) 9601 2244', MobilePhone = '0455 301 776'),
    new Contact(FirstName = 'Alistair', LastName = 'Quayle', AccountId = byName.get('Quayside Dental Rooms'),
                Title = 'Practice Manager', Email = 'alistair@quaysidedental.example',
                Phone = '(02) 9977 3120', MobilePhone = '0422 610 335'),
    new Contact(FirstName = 'Bronwyn', LastName = 'Teale', AccountId = byName.get('Brightwater Childcare'),
                Title = 'Centre Director', Email = 'bronwyn.teale@brightwatercc.example',
                Phone = '(02) 9899 6041', MobilePhone = '0407 552 901'),
    new Contact(FirstName = 'Samir', LastName = 'Haddad', AccountId = byName.get('Rosecliff Gardens Body Corporate'),
                Title = 'Committee Chair', Email = 's.haddad@rosecliffgardens.example',
                MobilePhone = '0428 114 663'),
    new Contact(FirstName = 'Janelle', LastName = 'Okonkwo', AccountId = byName.get('Ellersley Public Housing Trust'),
                Title = 'Maintenance Officer', Email = 'j.okonkwo@ellersley.example',
                Phone = '(02) 9707 1500', MobilePhone = '0466 208 447'),
    new Contact(FirstName = 'Rowan', LastName = 'Prescott', AccountId = byName.get('Mallowfield Retirement Village'),
                Title = 'Village Manager', Email = 'rowan.prescott@mallowfield.example',
                Phone = '(02) 9847 2210', MobilePhone = '0413 776 220'),
    new Contact(FirstName = 'Gemma', LastName = 'Hollis', AccountId = byName.get('Hollis Residence'),
                Title = 'Owner', Email = 'gemma.hollis@example.com', MobilePhone = '0412 345 678'),
    new Contact(FirstName = 'Chidi', LastName = 'Okafor', AccountId = byName.get('Okafor Residence'),
                Title = 'Owner', Email = 'chidi.okafor@example.com', MobilePhone = '0403 118 902'),
    new Contact(FirstName = 'Linh', LastName = 'Nguyen', AccountId = byName.get('Nguyen Residence'),
                Title = 'Owner', Email = 'linh.nguyen@example.com', MobilePhone = '0438 772 104'),
    new Contact(FirstName = 'Yannis', LastName = 'Petrakis', AccountId = byName.get('Petrakis Residence'),
                Title = 'Owner', Email = 'y.petrakis@example.com', MobilePhone = '0491 337 210'),
    new Contact(FirstName = 'Elspeth', LastName = 'Whitlow', AccountId = byName.get('Whitlow Residence'),
                Title = 'Owner', Email = 'elspeth.whitlow@example.com', MobilePhone = '0435 019 228'),
    new Contact(FirstName = 'Duane', LastName = 'Ferndale', AccountId = byName.get('Ferndale Motors'),
                Title = 'Dealer Principal', Email = 'duane@ferndalemotors.example',
                Phone = '(02) 9622 7788', MobilePhone = '0400 118 552'),
    new Contact(FirstName = 'Harriet', LastName = 'Ravensmill', AccountId = byName.get('Ravensmill Legal'),
                Title = 'Office Manager', Email = 'h.ravensmill@ravensmill.example',
                Phone = '(02) 9264 0091'),
    new Contact(FirstName = 'Tomasz', LastName = 'Korbel', AccountId = byName.get('Corbray Fitness Studio'),
                Title = 'Owner', Email = 'tomasz@corbrayfitness.example', MobilePhone = '0448 990 217'),

    // ---- D7: malformed email addresses -------------------------------------
    new Contact(FirstName = 'Nadia', LastName = 'Vasquez', AccountId = byName.get('Ashcombe Strata Mgmt Pty Ltd'),
                Title = 'Accounts', Email = 'nadia.vasquez@gmail.con',      // typo TLD
                MobilePhone = '0419 662 018'),
    new Contact(FirstName = 'Bernard', LastName = 'Kowalczyk', AccountId = byName.get('TARRENFORD AGED CARE'),
                Title = 'Night Supervisor', Email = 'b.kowalczyk@hotmial.com', // typo domain
                MobilePhone = '0432 887 110'),
    new Contact(FirstName = 'Sione', LastName = 'Fifita', AccountId = byName.get('Delmont Bakehouse'),
                Title = 'Baker', Email = 'sione@delmontbakehouse',            // no TLD
                MobilePhone = '0406 771 339'),
    new Contact(FirstName = 'Adaeze', LastName = 'Umeh', AccountId = byName.get('Ferndale Motors'),
                Title = 'Service Manager', Email = 'adaeze.umeh@ ferndalemotors.example', // embedded space
                Phone = '(02) 9622 7788'),

    // ---- D8: contacts with no reachable phone number -----------------------
    new Contact(FirstName = 'Colm', LastName = 'Bradaigh', AccountId = byName.get('Delmont Bakehouse '),
                Title = 'Owner', Email = 'colm@delmontbakehouse.example'),
    new Contact(FirstName = 'Renata', LastName = 'Silvestri', AccountId = byName.get('Corbray Fitness Studio'),
                Title = 'Duty Manager', Email = 'renata@corbrayfitness.example')
};

Database.SaveResult[] conResults = Database.insert(contacts, false);
Integer conOk = 0;
for (Database.SaveResult r : conResults) {
    if (r.isSuccess()) { conOk++; } else { System.debug('CONTACT FAILED: ' + r.getErrors()); }
}

System.debug('Seed 01 complete. Accounts inserted: ' + acctOk + '/' + accounts.size()
             + ', Contacts inserted: ' + conOk + '/' + contacts.size());
