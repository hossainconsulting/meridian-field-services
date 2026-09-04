/*
 * Meridian Field Services - seed reset.
 *
 * DESTRUCTIVE. Deletes every Service Job, Technician, Contact and Account in
 * the target org so the seed scripts can be re-run from a known state.
 *
 * Only ever run this against a Developer Edition or scratch org that exists
 * solely for this project. It does not discriminate between seeded records and
 * anything else you happen to have created.
 *
 * Job line items are not deleted explicitly - they are master-detail children
 * of Service Job and go with the parent.
 *
 * Run:  sf apex run --file seed/00_reset.apex --target-org meridian
 */

delete [SELECT Id FROM Service_Job__c LIMIT 10000];
delete [SELECT Id FROM Technician__c LIMIT 10000];
delete [SELECT Id FROM Contact LIMIT 10000];
delete [SELECT Id FROM Account LIMIT 10000];

System.debug('Reset complete. Jobs: ' + [SELECT COUNT() FROM Service_Job__c]
             + ', Technicians: ' + [SELECT COUNT() FROM Technician__c]
             + ', Accounts: ' + [SELECT COUNT() FROM Account]);
