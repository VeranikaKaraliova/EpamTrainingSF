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
}
