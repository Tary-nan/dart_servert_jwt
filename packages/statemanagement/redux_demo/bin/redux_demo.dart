import 'package:mongo_dart/mongo_dart.dart';
import 'package:redux/redux.dart';
import 'package:redux_demo/redux_demo.dart';
import 'package:redux_demo/src/databasse/database.dart';
import 'package:redux_demo/src/todos/middleware/fetch.dart';
import 'package:redux_demo/src/todos/redux/actions/fetch_todo_action.dart';
import 'package:redux_demo/src/todos/todos_app.dart';
import 'package:redux_thunk/redux_thunk.dart';

// void main(List<String> args)async{
 
//   await DB.open();
//   final store = Store<TodoState>(
//     appStateReducer,
//     initialState: TodoState(),
//     middleware: [fetchTodosMiddleware, thunkMiddleware],
//   );

//    var app = TodosApp(store);
//    //app.listen();

//  print('_____________ FETCH ______________');
//   // Dispatch the FetchTodosAction.
//  store.dispatch(FetchTodosAction());


//   //print('_____________ ISFETCHING ______________');
//   //print(store.state.isFetching); // prints "True"
//   // print('_____________ TODOS ______________');
//   // print(store.state.todos); // prints an empty list

//   // // // After the API returns, it should update the state
//   // print(store.state.isFetching); // prints "False" now
//   // print(store.state.todos); // prints a list of fetched todos
//   // print(store.state.isFetching);
//   // print('????????????????????????????????????????');
//    if(store.state.isFetching){
      
//       app.add(5.toString(), 'hello world 5');
//       app.storeState(store.state);
//    }
  
//   // app.remove(3.toString());
//   // app.remove(4.toString());
//   // app.update(1.toString(), Todo(completed: true, text: 'cococa', id: 1.toString()));
//   // print('_________UPDATE_______');
//   // app.visibilty(VisibilityFilter.SHOW_ACTIVE);
//   // 
//   // // app.storeState(store.state);
//   // app.add(6.toString(), 'hello world 6');
//   // app.visibilty(VisibilityFilter.SHOW_COMPLETED);

//   // app.toggle(3.toString());

//   // app.storeState(store.state);

//   // app.remove(2.toString());
// }

void main(List<String> arguments) {
  // Create the store with our Reducer and Middleware
  final store = Store<int>(
    counterReducer,
    initialState: initialState,
    middleware: [loggingMiddleware],
  );

  var app = CounterApp(store);
  app.listen(); // ecoute le flux
  app.increment();

  print('___________FIN___________');
}
