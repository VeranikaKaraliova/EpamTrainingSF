@IsTest
private class AccountTriggerTest {
	@IsTest // for AccountTriggerHelper.createFirstContact
    public static void createFirstContactTest(){

        List<Account> newListAcc = TestDataFactory.ACCOUNT.creatListAccData(3, 'Nika', false);
        List<Contact> expectedContList = new List<Contact>(); 

        for(Account a : newListAcc){
            expectedContList.add(new Contact(FirstName ='First user',
                                            LastName = a.Name,
                                            Phone = a.Phone,
                                            AccountId = a.Id));
        }
        
        Test.startTest();
        insert newListAcc;
        Test.stopTest();

        List<Id> accId = new List <Id>();
        for(Account a :newListAcc){
            accId.add(a.Id);
        }
        
        List <Contact> realContact = [SELECT LastName FROM Contact WHERE AccountID =: accId];
        for(Integer i=0; i<3; i++){
            System.assertNotEquals(null, realContact[i]);
        	System.assertEquals(expectedContList[i].LastName, realContact[i].LastName);
        }
    }

    @IsTest // for future trigger method's taskIsSynced
    public static void taskIsSyncedTest(){
        List<Account> newListAcc = TestDataFactory.ACCOUNT.creatListAccData(5, 'Nika', true);
		List<Task> newListTasks = TestDataFactory.TASKS.creatTaskWithAccount(newListAcc, true, true);
        for(Account a : newListAcc){
            a.Name = 'Nata';
        }
        
        Test.startTest();
        update newListAcc;
        Test.stopTest();
        
        List<Task> realListTasks = [SELECT Is_Synced__c FROM Task];
        System.assertEquals(false, realListTasks[0].Is_Synced__c);
    }

    @IsTest
    public static void contactsProcessedByFutureTest(){
    	List<Account> newListAcc = TestDataFactory.ACCOUNT.creatListAccData(3, 'Nika', true);
		List<Contact> newListContacts = TestDataFactory.CONTACT.creatContactWithAccount(newListAcc, true);
        for(Account a : newListAcc){
            a.BillingStreet = 'Kosmonavtov';
        }
        
        Test.startTest();
        update newListAcc;
        Test.stopTest();
        
        List<Contact> realListContacts = [SELECT Is_Synced__c, Processed_By_Future__c FROM Contact];
        System.assertEquals(false, realListContacts[0].Is_Synced__c);
        System.assertEquals(true, realListContacts[0].Processed_By_Future__c);
    }

    @IsTest
    public static void addressQueueableTest(){
        List<Account> newListAcc = TestDataFactory.ACCOUNT.creatListAccData(3, 'Nika', true);
        List<Contact> newListContacts = TestDataFactory.CONTACT.creatContactWithAccount(newListAcc, false, true, true);
        for(Account a : newListAcc){
            a.BillingCity = 'Mogilev';
        }
        
        Test.startTest();
        update newListAcc;
        Test.stopTest();
        
        List<Contact> realListContacts = [SELECT Is_Synced__c, Processed_By_Future__c FROM Contact];
        System.assertEquals(true, realListContacts[0].Is_Synced__c);
        System.assertEquals(false, realListContacts[0].Processed_By_Future__c);
    }

}
