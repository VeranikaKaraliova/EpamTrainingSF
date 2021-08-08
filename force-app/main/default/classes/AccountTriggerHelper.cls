public with sharing class AccountTriggerHelper {
    public static void createFirstContact(List<Account> triggerNew){
        List<Contact> contList = new List<Contact>();
        Map<Id,Account> acctsWithContacts = new Map<Id,Account>([
            SELECT Id,(SELECT Id FROM Contacts) 
            FROM Account 
            WHERE Id IN :triggerNew
            ]);
            
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
        List<Account> listAcc = [
            SELECT Id 
            FROM Account 
            WHERE Id in : triggerNew
            ];
        List<ID> idAcc = new List<ID>();
        for(Account a : listAcc){
            idAcc.add(a.Id);
        }
        taskIsSynced(idAcc);
    }
    
    @future
    public static void taskIsSynced(List<ID> idAcc){
        List<Task> tasks = [
            SELECT Id, Is_Synced__c 
            FROM Task 
            WHERE WhatId IN :idAcc
            ];
        for(Task t : tasks){
            t.Is_Synced__c = false;
        }
        update tasks;
    }

    public static void changedBillingAddress(List<Account> triggerNew, Map<ID,Account> triggerOldMap, Map<ID,Account> triggerNewMap){
        List <ID> idAcc = new List <ID>();
        for(Account a :triggerNew){
            Account oldAcc = triggerOldMap.get(a.Id);
            Account newAcc = triggerNewMap.get(a.Id);

            if(oldAcc.BillingStreet != newAcc.BillingStreet){
                idAcc.add(a.Id);
            }
        }
        contactsProcessedByFuture(idAcc);
    }
    
    @future
    public static void contactsProcessedByFuture (List<ID> idAcc){
        List<Contact> contacts = [
            SELECT Id, Is_Synced__c, Processed_By_Future__c 
            FROM Contact 
            WHERE AccountId IN :idAcc
        ];

        for(Contact c : contacts){
            c.Is_Synced__c = false;
            c.Processed_By_Future__c = true;
        }
        update contacts;
    }
}
