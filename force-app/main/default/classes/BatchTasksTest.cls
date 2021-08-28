@IsTest
public class BatchTasksTest {
@IsTest
    public static void batchTasksTest(){
    	List<Account> newListAcc = TestDataFactory.ACCOUNT.creatListAccData(3, 'Nika', true);
		List<Task> newListTasks = TestDataFactory.TASKS.creatTaskWithAccount(newListAcc, false, true);
        
        Test.startTest();
        BatchTasks batch = new BatchTasks();
        Id batchId = Database.executeBatch(batch);
        Test.stopTest();
        
        List<Account> realListAcc = [SELECT Updated_By_Task__c FROM Account];
        List<Task> realListTask = [SELECT Is_Synced__c, Account_Owner__c FROM Task];
        System.assertEquals(true, realListAcc[0].Updated_By_Task__c);
        System.assertEquals(true, realListTask[0].Is_Synced__c);
        System.assertEquals(null, newListTasks[0].Account_Owner__c);
        System.assertNotEquals(null, realListTask[0].Account_Owner__c);
        
    }
}
