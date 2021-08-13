public class BatchContactMailingAddress implements Database.Batchable<sObject>, Database.Stateful {
	public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, AccountId, MailingStreet, ' + 
            'MailingCountry,MailingCity, Is_Synced__c ' + 
            'FROM Contact ' + 
            'WHERE Is_Synced__c = false');
    }
    
    public void execute(Database.BatchableContext bc,List<Contact> contacts){
        List<ID> idForAcc = new List<ID>(); 
        
        for(Contact c : contacts){
            idForAcc.add(c.AccountId);
        }

        Map<Id, Account> mapAcc = new Map<Id, Account>();
        List<Account> acc = [
            SELECT ID, Updated_By_Contact__c, BillingStreet, BillingCity, BillingCountry 
            FROM Account WHERE Id in:idForAcc 
            ];
        
        for(Account a : acc){
            mapAcc.put(a.Id, a);
        }
		
        for(Contact c : contacts){
            c.Is_Synced__c = true;
            c.MailingStreet= mapAcc.get(c.AccountId).BillingStreet;
            c.MailingCity= mapAcc.get(c.AccountId).BillingCity;
            c.MailingCountry= mapAcc.get(c.AccountId).BillingCountry;
        }

        for(Account a : acc){
            a.Updated_By_Contact__c = true;
        }

        update contacts;
        update acc;
    }
    
    public void finish(Database.BatchableContext bc){

    }
}
