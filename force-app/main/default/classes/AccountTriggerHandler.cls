public with sharing class AccountTriggerHandler {
    public static void handlerAfterInsert(List<Account> triggerNew){
        AccountTriggerHelper.createFirstContact(triggerNew);
    }
}
