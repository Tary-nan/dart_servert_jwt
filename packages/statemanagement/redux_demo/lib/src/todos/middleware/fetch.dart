import 'package:redux/redux.dart';
import 'package:redux_demo/src/todos/redux/actions/fetch_todo_action.dart';
import 'package:redux_demo/src/todos/redux/state/todo_state.dart';

void fetchTodosMiddleware(Store<TodoState> store, action, NextDispatcher next) {
  if (action is FetchTodosAction) {
    final api = TodosApi();
    api.fetchTodos().then((List<Todo> todos) {
      store.dispatch(FetchTodosSucceededAction(todos));
    }).catchError((Exception error) {
      store.dispatch(FetchTodosFailedAction(error));
    });
  }
  next(action);
}

class TodosApi {
  Future<List<Todo>> fetchTodos() async {
    return await Future.delayed(Duration(seconds: 05),
        () => [Todo(id: 1, text: 'hgf'), Todo(id: 2, text: 'hgf')]);
  }
}
