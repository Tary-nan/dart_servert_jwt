import 'package:redux_demo/src/todos/redux/actions/fetch_todo_action.dart';
// import 'package:redux_demo/src/todos/redux/reducers/todo_reducer.dart';
// import 'package:redux_demo/src/todos/redux/reducers/visibility_reducer.dart';
import 'package:redux_demo/src/todos/redux/state/todo_state.dart';

TodoState appStateReducer(TodoState state, action) {
  if (action is FetchTodosAction) {
    return TodoState(
        todos: state.todos, // todoReducer(state.todos, action),
        visibilityFilter: state
            .visibilityFilter, //visibilityReducer(state.visibilityFilter, action),
        isFetching: true,
        error: null);
  } else if (action is FetchTodosSucceededAction) {
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
  }
  return state;
}
