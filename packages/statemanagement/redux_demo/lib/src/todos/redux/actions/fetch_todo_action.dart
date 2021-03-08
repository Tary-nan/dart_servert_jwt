import 'package:redux_demo/src/todos/redux/state/todo_state.dart';

class FetchTodosAction {}

class FetchTodosSucceededAction {
  final List<Todo> fetchedTodos;
  
  FetchTodosSucceededAction(this.fetchedTodos);
}

class FetchTodosFailedAction {
  final Exception error;
  FetchTodosFailedAction(this.error);
}