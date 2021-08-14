@IsTest
public class AccountNewTaskTest {
	@isTest 
    static void accountNewTaskTest() {
        List<Account> newListAcc = new List<Account>{
        	new Account(Name = 'Nika')
        };
        insert newListAcc;
        
        Test.startTest();
        AccountNewTask.accountNewTask(newListAcc);
        Test.stopTest();

        Task task = [SELECT Subject FROM Task LIMIT 1];
        
        System.assertNotEquals(null, task);
        System.assertEquals('Negotiations with ' + newListAcc[0].Name, task.Subject);
    }

    @IsTest 
    static void listAccountNewTaskTest() {
        List<Account> newListAcc = TestDataFactory.ACCOUNT.creatListAccData(10, 'Nika', true);
                
        Test.startTest();
        AccountNewTask.accountNewTask(newListAcc);
        Test.stopTest();
        
        Task task = [SELECT Subject FROM Task LIMIT 1];
        
        System.assertNotEquals(null, task);
        System.assertEquals('Negotiations with ' + newListAcc[0].Name, task.Subject);
    }
}
