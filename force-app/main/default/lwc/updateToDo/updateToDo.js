import { LightningElement, wire, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import {refreshApex} from '@salesforce/apex'
import getTodoList from '@salesforce/apex/TodoController.getTodoList'
import TODO_OBJECT from '@salesforce/schema/Todo__c';
import NAME_FIELD from '@salesforce/schema/Todo__c.Name';
import CATEGORY_FIELD from '@salesforce/schema/Todo__c.Category__c';
import DESCRIPTION_FIELD from '@salesforce/schema/Todo__c.Description__c';
import IS_DONE_FIELD from '@salesforce/schema/Todo__c.Is_done__c';
import PRIORITY_FIELD from '@salesforce/schema/Todo__c.Priority__c';
import TITLE_FIELD from '@salesforce/schema/Todo__c.Title__c';

export default class UpdateToDo extends LightningElement {
  
  @api recordId;
  @api objectApiName = TODO_OBJECT;

  modalWindow = false;
  fields = [NAME_FIELD, TITLE_FIELD, CATEGORY_FIELD, PRIORITY_FIELD, IS_DONE_FIELD, DESCRIPTION_FIELD];
  
  openWindow(event){
    this.recordId = event.target.dataset.recordid;
    this.modalWindow = true;
  }
  closeWindow(){
    this.modalWindow = false;
  }

  @wire(getTodoList)
  toDos

  handleSuccess(event) {
    refreshApex(this.toDos);
    const toastEvent = new ShowToastEvent({
      title: "Todo update",
      variant: "success"
    });
    this.dispatchEvent(toastEvent);
  }

}