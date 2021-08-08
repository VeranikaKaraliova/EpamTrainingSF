public with sharing class BillingAddressQueueable implements Queueable{
    public List<Account> triggerNew;
    public Map<ID,Account> triggerOldMap;
    public Map<ID,Account> triggerNewMap;
    
    public BillingAddressQueueable(
        List<Account> triggerNew,
    	Map<ID,Account> triggerOldMap,
   		Map<ID,Account> triggerNewMap){
        this.triggerNew = triggerNew;
        this.triggerOldMap = triggerOldMap;
        this.triggerNewMap = triggerNewMap;
    }
	
    public void execute(QueueableContext context) {
        List <ID> idAcc = new List <ID>();

        for(Account a :triggerNew){
            Account oldAcc = triggerOldMap.get(a.Id);
            Account newAcc = triggerNewMap.get(a.Id);
            if(oldAcc.BillingCity != newAcc.BillingCity){
                idAcc.add(a.Id);
            }
        }
        
        List<Contact> contacts = [
            SELECT Id, Is_Synced__c, Processed_By_Future__c 
            FROM Contact 
            WHERE AccountId IN :idAcc
        ];
        
        for(Contact c : contacts){
            c.Is_Synced__c = true;
            c.Processed_By_Future__c = false;
        }
        update contacts;
    }
}
