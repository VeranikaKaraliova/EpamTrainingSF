@IsTest
public class BatchContactMailingAddressTest {
@IsTest
    public static void batchContactAddressTest (){
    	List<Account> newListAcc = TestDataFactory.ACCOUNT.creatListAccData(3, 'Nika', true);
		List<Contact> newListContacts = TestDataFactory.CONTACT.creatContactWithAccount(newListAcc, false, false, true);
        
        Test.startTest();
        BatchContactMailingAddress batch = new BatchContactMailingAddress();
        Id batchId = Database.executeBatch(batch);
        Test.stopTest();
        
        List<Contact> realListContacts = [SELECT MailingStreet, MailingCity, MailingCountry FROM Contact];
        System.assertNotEquals(newListContacts[0].MailingStreet, realListContacts[0].MailingStreet);
        System.assertEquals(newListAcc[0].BillingStreet, realListContacts[0].MailingStreet);
        
    }
}
