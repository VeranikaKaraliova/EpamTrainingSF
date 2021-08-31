import { LightningElement, wire} from 'lwc';
import getTodoList from '@salesforce/apex/TodoController.getTodoList'
import getTodo from '@salesforce/apex/TodoController.getTodo'

export default class ItemToDo extends LightningElement {
  selectedTodo;
  
  @wire(getTodo,{key: '$this.selectedTodo'})
  toDo

  @wire(getTodoList)
  listTodo;

  viewTodo(event){
    const todoId= event.detail;
    this.selectedTodo = this.listTodo.data.find((todo)=>todo.Id === todoId)
  }
}
