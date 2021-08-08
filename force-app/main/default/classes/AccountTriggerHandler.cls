public with sharing class AccountTriggerHandler {
    
    public static void handlerAfterInsert(List<Account> triggerNew){
        AccountTriggerHelper.createFirstContact(triggerNew);
    }

    public static void handlerAfterUpdate(List<Account> triggerNew){
        AccountTriggerHelper.returnIDAcc(triggerNew);
    }

    public static void handlerBeforeUpdate(List<Account> triggerNew, Map<ID,Account> triggerOldMap, Map<ID,Account> triggerNewMap){
        AccountTriggerHelper.changedBillingAddress(triggerNew, triggerOldMap, triggerNewMap);
    }
}
