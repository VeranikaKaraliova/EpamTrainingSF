public class BatchTasks implements Database.Batchable<sObject>, Database.Stateful{

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT ID, OwnerId, Account_Owner__c, Is_Synced__c, WhatId FROM Task WHERE Is_Synced__c = false');
    }
    
    public void execute(Database.BatchableContext bc, List<Task> tasks){
        
        System.debug('tasks' + tasks);
        List<ID> idForAcc = new List<ID>(); 
        for(Task t : tasks){
            idForAcc.add(t.WhatId);
        }
        Map<Id, Account> mapAcc = new Map<Id, Account>();
        List<Account> acc = [
            SELECT ID, Account.Owner.Name, Updated_By_Task__c 
            FROM Account 
            WHERE Id in:idForAcc 
            ];

        for(Account a : acc){
            mapAcc.put(a.Id, a);
        }
        
        for(Task t : tasks){
            t.Is_Synced__c = true;
            t.Account_Owner__c = mapAcc.get(t.WhatId).Owner.Name;
        }

        for(Account a : acc){
            a.Updated_By_Task__c = true;
        }
        
        update tasks;
        update acc;
    }
    
    public void finish(Database.BatchableContext bc){

    }
}
