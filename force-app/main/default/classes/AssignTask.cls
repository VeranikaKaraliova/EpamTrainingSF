public with sharing class AssignTask {
    @InvocableMethod
    public static void assignTask(List <Id> listAcc) {
        User anotherUser = [SELECT Id, Name FROM User WHERE isActive = true LIMIT 1];
        
        Set <Id> setAcc = new Set <Id> (listAcc);
        List <Task> allTasks = [SELECT Id, WhatId FROM Task];
        List <Task> upTasks = new List<Task>();
        
        for(Task task : allTasks){
            if(setAcc.contains(task.WhatId)){
                upTasks.add(task);
                if(upTasks.size() >= 3){
                    for(Task t : upTasks){
                    	t.OwnerId = anotherUser.ID;
                	} 
                }
            }
        }
        update upTasks;
    }
}