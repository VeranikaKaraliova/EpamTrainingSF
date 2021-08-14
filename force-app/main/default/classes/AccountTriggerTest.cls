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
}
