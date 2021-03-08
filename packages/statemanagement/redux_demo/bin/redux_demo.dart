import 'package:redux/redux.dart';
import 'package:redux_demo/redux_demo.dart';
import 'package:redux_demo/src/todos/middleware/fetch.dart';
import 'package:redux_demo/src/todos/redux/actions/fetch_todo_action.dart';
import 'package:redux_demo/src/todos/todos_app.dart';

void main(List<String> args) {
  final store = Store<TodoState>(
    appStateReducer,
    initialState: TodoState(),
    middleware: [fetchTodosMiddleware],
  );

  var app = TodosApp(store);
  app.listen();

  print('_____________ FETCH ______________');
  // Dispatch the FetchTodosAction.
 store.dispatch(FetchTodosAction());

  //print('_____________ ISFETCHING ______________');
  //print(store.state.isFetching); // prints "True"
  // print('_____________ TODO ______________');
  // print(store.state.todos); // prints an empty list

  // // // After the API returns, it should update the state
  // print(store.state.isFetching); // prints "False" now
  // print(store.state.todos); // prints a list of fetched todos

  app.add(1, 'hello world 1');
  // app.update(1, Todo(completed: true, text: 'cococa', id: 1));
  // print('_________UPDATE_______');
  // app.visibilty(VisibilityFilter.SHOW_ACTIVE);
  // app.add(2, 'hello world 2');
  // // app.storeState(store.state);
  // app.add(3, 'hello world 3');
  // app.visibilty(VisibilityFilter.SHOW_COMPLETED);

  // app.toggle(3);

  // app.storeState(store.state);

  // app.remove(2);
}

// void main(List<String> arguments) {
//   // Create the store with our Reducer and Middleware
//   final store = Store<int>(
//     counterReducer,
//     initialState: initialState,
//     middleware: [loggingMiddleware],
//   );

//   var app = CounterApp(store);
//   app.listen(); // ecoute le flux
//   app.increment();
//   app.increment();
//   app.storeState(store.state);
//   app.increment();
//   app.decrement();
//   print('___________FIN___________');
// }
