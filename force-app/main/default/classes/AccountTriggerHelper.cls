public with sharing class AccountTriggerHelper {
    public static void createFirstContact(List<Account> triggerNew){
        List<Contact> contList = new List<Contact>();
        Map<Id,Account> acctsWithContacts = new Map<Id,Account>([SELECT Id,(SELECT Id FROM Contacts) 
                                                                FROM Account WHERE Id IN :triggerNew]);
        for(Account a : triggerNew){
            if(acctsWithContacts.get(a.Id).Contacts.size() == 0){
                contList.add(new Contact (FirstName ='First user',
                                            LastName = a.Name,
                                            Phone = a.Phone,
                                            AccountId = a.Id));
            }
        }
        if (contList.size() >0){
            insert contList;
        }
    }
    
    public static void returnIDAcc(List<Account> triggerNew){
        List<Account> listAcc = new List<Account>([SELECT Id FROM Account Where Id in : triggerNew]);
        List<ID> idAcc = new List<ID>();
        for(Account a : listAcc){
            idAcc.add(a.Id);
        }
        taskIsSynced(idAcc);
    }
    
    @future
    public static void taskIsSynced(List<ID> idAcc){
        List<Task> tasks = [SELECT Id, Is_Synced__c 
                            FROM Task WHERE WhatId IN :idAcc];
        for(Task t : tasks){
            t.Is_Synced__c = false;
        }
        update tasks;
    }
}
