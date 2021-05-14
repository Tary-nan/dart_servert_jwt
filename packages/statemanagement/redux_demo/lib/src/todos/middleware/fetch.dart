import 'package:mongo_dart/mongo_dart.dart';
import 'package:redux/redux.dart';
import 'package:redux_demo/src/constants/database.dart';
import 'package:redux_demo/src/databasse/collections/user_collection.dart';
import 'package:redux_demo/src/databasse/database.dart';
import 'package:redux_demo/src/todos/redux/actions/add_todo_action.dart';
import 'package:redux_demo/src/todos/redux/actions/fetch_todo_action.dart';
import 'package:redux_demo/src/todos/redux/actions/remove_todo_action.dart';
import 'package:redux_demo/src/todos/redux/actions/update_todo_action.dart';
import 'package:redux_demo/src/todos/redux/state/todo_state.dart';
import 'package:redux_thunk/redux_thunk.dart';


ThunkAction<TodoState> fetchData(DbCollection collection){
  return (Store<TodoState> store)async{
    var todos = await collection.find().map((data) => Todo.fromJson(data)).toList();
    store.dispatch(FetchTodosSucceededAction(todos));
  };
}

void fetchTodosMiddleware(Store<TodoState> store, action, NextDispatcher next) async{

  //   if (action is FetchTodosAction) {
  //   final api = TodosApi();
  //   await api.fetchTodos().then((List<Todo> todos) {
  //     store.dispatch(FetchTodosSucceededAction(todos));
  //   }).catchError((Exception error) {
  //     store.dispatch(FetchTodosFailedAction(error));
  //   });
  // }
  next(action);
  var collection = await DB.todoCollection;
  if(action is FetchTodosAction){
    
    List todoCollection = await TodoCollection(collection).todos();
    store.dispatch(FetchTodosSucceededAction(todoCollection));
  }else if(action is AddTodoAction){
     await TodoCollection(collection).createTodo({
      'id' : action.id,
      'text': action.text,
      'completed' : null
    });
  }else if(action is RemoveTodoAction){
     await TodoCollection(collection).delete(id: action.id);
  }else if(action is UpdateTodoAction){
     await TodoCollection(collection).createTodo({
      'id' : action.id,
    });
  }
  
}

class TodosApi {
  Future<List<Todo>> fetchTodos() async {
    return await Future.delayed(Duration(seconds: 05),
        () => [Todo(id: 1.toString(), text: 'hgf'), Todo(id: 2.toString(), text: 'hgf')]);
  }
}
