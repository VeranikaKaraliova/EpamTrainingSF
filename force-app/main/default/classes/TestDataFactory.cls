@IsTest
public class TestDataFactory {
	public static TestAccountFactory ACCOUNT = new TestAccountFactory();
	public static TestTaskFactory TASKS = new TestTaskFactory();
	public static TestContactFactory CONTACT = new TestContactFactory();
    
    public class TestAccountFactory{
        public Account creatAccData(String name, Boolean needInsert){
            Account acc = new Account();
            acc.Name = name;
            acc.BillingStreet = 'Sovetskaya';
            acc.BillingCity = 'Minsk';
            acc.BillingCountry = 'RB';
            if(needInsert) insert acc;
            return acc;
        }
        
        public List<Account> creatListAccData(Integer count, String name, Boolean needInsert){
            List<Account> acc = new List<Account>();
            for(Integer i = 0; i<= count; i++){
                acc.add(creatAccData(name, false));
            }
            if(needInsert) insert acc;
            return acc;
        }
    }
    
    public class TestTaskFactory{
        public List <Task> creatTaskWithAccount (List <Account> newListAcc,Boolean IsSynced, Boolean needInsert){
			List<Task> tasks = new List<Task>();
            for(Account a : newListAcc){
                tasks.add(new Task (
                    Subject = 'Negotiations with ' + a.Name, 
                    WhatId = a.Id, 
                    Is_Synced__c = IsSynced));
            }
            if(needInsert) insert tasks;
            return tasks;
        }
    }

    public class TestContactFactory{
        public List <Contact> creatContactWithAccount (List <Account> newListAcc, Boolean IsSynced, Boolean ProcessedByFuture, Boolean needInsert){
			List<Contact> contacts = new List<Contact>();
            for(Account a : newListAcc){
                contacts.add(new Contact (
                    FirstName ='First user',
                    LastName = a.Name, 
                    AccountId = a.Id, 
                    Is_Synced__c = IsSynced,
                    Processed_By_Future__c = ProcessedByFuture));
            }
            if(needInsert) insert contacts;
            return contacts;
        }
    }
}
