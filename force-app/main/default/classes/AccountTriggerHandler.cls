public with sharing class AccountTriggerHandler {
    
    public static void handlerAfterInsert(List<Account> triggerNew){
        AccountTriggerHelper.createFirstContact(triggerNew);
    }

    public static void handlerAfterUpdate(List<Account> triggerNew){
        AccountTriggerHelper.returnIDAcc(triggerNew);
    }
}
