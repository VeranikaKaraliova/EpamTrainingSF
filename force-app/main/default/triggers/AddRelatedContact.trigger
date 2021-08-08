trigger AddRelatedContact on Account (
        after delete, 
        after insert, 
        after undelete, 
        after update, 
        before delete, 
        before insert, 
        before update) {

  if(Trigger.isInsert && Trigger.isAfter){
    AccountTriggerHandler.handlerAfterInsert(Trigger.new);
  }

  if(Trigger.isUpdate && Trigger.isAfter){
    AccountTriggerHandler.handlerAfterUpdate(Trigger.new);
  }

}