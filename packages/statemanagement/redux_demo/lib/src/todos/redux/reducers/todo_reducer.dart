import 'package:redux/redux.dart';
import 'package:redux_demo/src/todos/redux/actions/add_todo_action.dart';
import 'package:redux_demo/src/todos/redux/actions/remove_todo_action.dart';
import 'package:redux_demo/src/todos/redux/actions/toggle_action.dart';
import 'package:redux_demo/src/todos/redux/actions/update_todo_action.dart';
import 'package:redux_demo/src/todos/redux/state/todo_state.dart';

// Compose these smaller functions into the full `todoReducer`.
Reducer<List<Todo>> todoReducer = combineReducers<List<Todo>>([
  TypedReducer<List<Todo>, AddTodoAction>(addTodoReducer),
  TypedReducer<List<Todo>, RemoveTodoAction>(removeTodoReducer),
  TypedReducer<List<Todo>, ToggleTodoAction>(toggleTodoReducer),
  TypedReducer<List<Todo>, UpdateTodoAction>(updateTodoReducer),
]);

// UpdateTodoAction
List<Todo> updateTodoReducer(List<Todo> state, UpdateTodoAction action) {
  final index = state.indexWhere((todo) => todo.id == action.id);
  if (index >= 0) {
    state[index] = action.todo;
  }
  return [...state];
}

List<Todo> addTodoReducer(List<Todo> state, AddTodoAction action) {
  print(action.id);
  return [...state, Todo(id: action.id, text: action.text, completed: false)];
}
    

List<Todo> toggleTodoReducer(List<Todo> state, ToggleTodoAction action) => state
    .map((todo) => (todo.id.toString().contains(action.id.toString())
        ? todo.copyWith(completed: !todo.completed)
        : todo))
    .toList();

List<Todo> removeTodoReducer(List<Todo> todos, RemoveTodoAction action) =>
    todos.where((element) => element.id != action.id).toList();
