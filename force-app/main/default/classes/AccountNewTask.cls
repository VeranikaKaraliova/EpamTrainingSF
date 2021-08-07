public with sharing class AccountNewTask {
    @InvocableMethod
    public static void AccountNewTask(List<Account> newListAcc) {
        List <Task> allNewTask = new List<Task>();
        for(Account acc : newListAcc){
            allNewTask.add(new Task(Subject = 'Negotiations with ' + acc.Name, WhatId = acc.Id));
        }
        insert allNewTask;
    }
}