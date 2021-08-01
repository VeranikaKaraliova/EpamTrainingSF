public with sharing class AssignTask {
    @InvocableMethod
    public static void AssignTask(List<Account> listAcc) {
        For(Account acc : listAcc){
            String nameAcc = 'Negotiations with ' + acc.Name;
            List <Task> allTask = [SELECT Id FROM Task WHERE Subject =: nameAcc];
            
            if(allTask.size()>= 3){
                for(Task task : allTask){
                    task.OwnerId = '0055g00000AlscrAAB';
                } 
            }
        	update allTask;
        }
    }
}
