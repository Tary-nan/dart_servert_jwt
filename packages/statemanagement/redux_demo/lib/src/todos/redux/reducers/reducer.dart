import 'package:redux_demo/src/todos/redux/actions/add_todo_action.dart';
import 'package:redux_demo/src/todos/redux/actions/fetch_todo_action.dart';
import 'package:redux_demo/src/todos/redux/actions/remove_todo_action.dart';
import 'package:redux_demo/src/todos/redux/actions/update_todo_action.dart';
import 'package:redux_demo/src/todos/redux/reducers/todo_reducer.dart';
// import 'package:redux_demo/src/todos/redux/reducers/todo_reducer.dart';
// import 'package:redux_demo/src/todos/redux/reducers/visibility_reducer.dart';
import 'package:redux_demo/src/todos/redux/state/todo_state.dart';

TodoState appStateReducer(TodoState state, action) {
  if (action is FetchTodosAction) {
    return TodoState(
        todos: todoReducer(state.todos, action),
        visibilityFilter: state
            .visibilityFilter, //visibilityReducer(state.visibilityFilter, action),
        isFetching: true,
        error: null);
  } else if (action is FetchTodosSucceededAction) {
    print('get data');
    print(action.fetchedTodos.length);
    return TodoState(
        todos: action.fetchedTodos,
        visibilityFilter: state
            .visibilityFilter, //visibilityReducer(state.visibilityFilter, action),
        isFetching: false,
        error: null);
  } else if (action is FetchTodosFailedAction) {
    return TodoState(
        todos: const [],
        visibilityFilter: state.visibilityFilter,
        isFetching: false,
        error: state.error);
  }else if (action is AddTodoAction) {
    print(action);
    print(state.todos);
    return TodoState(
        todos: todoReducer(state.todos, action),
        visibilityFilter: state
            .visibilityFilter, //visibilityReducer(state.visibilityFilter, action),
        isFetching: false,
        error: null);
  }else if (action is RemoveTodoAction) {
    return TodoState(
        todos: todoReducer(state.todos, action),
        visibilityFilter: state
            .visibilityFilter, //visibilityReducer(state.visibilityFilter, action),
        isFetching: false,
        error: null);
  }else if (action is UpdateTodoAction) {
    return TodoState(
        todos: todoReducer(state.todos, action),
        visibilityFilter: state
            .visibilityFilter, //visibilityReducer(state.visibilityFilter, action),
        isFetching: false,
        error: null);
  }
  return state;
}
