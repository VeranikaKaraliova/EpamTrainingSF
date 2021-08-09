public with sharing class RunScheduled implements Schedulable{
    public void execute(SchedulableContext ctx) {
        Id runBatchTasks = Database.executeBatch(new BatchTasks());
        id runBatchContactMailingAddress = Database.executeBatch(new BatchContactMailingAddress());
    }
    
}
