import { LightningElement, wire } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import {refreshApex} from '@salesforce/apex'
import getTodoList from '@salesforce/apex/TodoController.getTodoList'
export default class DeleteToDo extends LightningElement {

  toDos;
  error;

  wireTodoResults;

  @wire(getTodoList)
  wireTodo(result){
    this.wireTodoResults = result;
    if(result.data){
      this.toDos = result.data;
      this.error = undefined;
    } else if (result.error) {
      this.error = result.error;
      this.toDos = undefined;
    }
  }

  deleteRecord(event){
    let recordId = event.target.dataset.recordid;
    deleteRecord(recordId)
      .then(()=>{
        this.dispatchEvent(
          new ShowToastEvent({
          title: "Todo deleted",
          variant: "success"
          })
        )
        return refreshApex(this.wireTodoResults);
      })
      .catch((error)=>{
        this.dispatchEvent(
          new ShowToastEvent({
            title: "ERROR",
            message: "Record not deleted",
            variant: "error"
          })
        )
      })
  }
  refrehListtTodo(){
    refreshApex(this.wireTodoResults);
  }

}