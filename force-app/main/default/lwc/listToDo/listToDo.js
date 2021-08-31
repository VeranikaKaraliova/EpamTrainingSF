import { LightningElement, wire } from 'lwc';
import getTodoList from '@salesforce/apex/TodoController.getTodoList'

export default class ListToDo extends LightningElement {
  toDos;
  error;

  @wire(getTodoList)
  listTodo(result){
    if(result.data){
      this.toDos = result.data;
      this.error = undefined;
    } else if (result.error) {
      this.error = result.error;
      this.toDos = undefined;
    }
  }

  handlClick(event){
    event.preventDefault();
    let newEvent = new CustomEvent('select',{detail :event.target.dataset.totoid});
    this.dispatchEvent(newEvent);
  }

}