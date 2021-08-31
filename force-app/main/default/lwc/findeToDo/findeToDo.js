import { LightningElement, wire } from 'lwc';
import findeTodo from '@salesforce/apex/TodoController.findeTodo'

export default class FindeToDo extends LightningElement {

  searchKey;

  @wire(findeTodo, {key: '$searchKey'})
  listTodo;

  findeRecord(event){
    window.clearTimeout(this.delayTimeOut)
    const key = event.target.value;
    this.delayTimeOut = setTimeout(()=>{
      this.searchKey = key;
    },300)
  }
}