public with sharing class AssignTask {
    @InvocableMethod
    public static void assignTask(List <Id> listAcc) {
        User anotherUser = [SELECT Id, Name FROM User WHERE isActive = true LIMIT 1];
        
        Set <Id> setAcc = new Set<Id>(listAcc);
        List <Task> allTasks = [SELECT Id, WhatId, OwnerId FROM Task WHERE WhatId = :setAcc];
       	Map<Id, List<Task>> mapTasks = new Map<Id, List<Task>>();
        List<Task> upTasks = new List<Task>();
        
        for(Task task : allTasks){
            if(setAcc.contains(task.WhatId)){
                upTasks.add(task);
                mapTasks.put(task.WhatId, upTasks);
            }
            if(mapTasks.get(task.WhatId).size() >= 3){
            	for(Task t : mapTasks.get(task.WhatId)){
            		t.OwnerId = anotherUser.Id;
                }
            }
        }
        update upTasks;
    }
}