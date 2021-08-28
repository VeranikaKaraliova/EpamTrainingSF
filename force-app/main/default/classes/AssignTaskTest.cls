@IsTest
public class AssignTaskTest {
	@isTest 
    static void assignTaskTest() {
        
        List<Account> newListAcc = TestDataFactory.ACCOUNT.creatListAccData(1, 'Nika', true);
        List <Task> tasks = new List <Task>();
        List <Id> listAccId = new List <Id>();

        for(Integer i=0; i<=3; i++){
            tasks.add(new Task(Subject = 'Negotiations with ' + newListAcc[0].Name, WhatId = newListAcc[0].Id));
        }
        insert tasks;

        For(Account a :newListAcc){
            listAccId.add(a.Id);
        }
        
        Test.startTest();
        AssignTask.assignTask(listAccId);
        Test.stopTest();
        
        LIST <Task> newTasks = [SELECT OwnerId FROM Task];
        System.assertEquals(newTasks[0].OwnerId, newTasks[1].OwnerId);
        System.assertEquals(newTasks[0].OwnerId, newTasks[2].OwnerId);
        System.assertEquals(newTasks[1].OwnerId, newTasks[2].OwnerId);
    }
}
