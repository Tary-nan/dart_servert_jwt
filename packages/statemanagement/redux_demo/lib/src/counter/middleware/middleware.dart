import 'package:redux/redux.dart';
import 'package:redux_demo/src/counter/redux/actions/counter_action.dart';

void loggingMiddleware(Store<int> store, action, NextDispatcher next)async {
print(action);
if (action == Action.increment) {
  await Future.delayed(Duration(seconds: 10),(){
    print('Qpres 10 secondes action => decremente');
  });
  store.dispatch(Action.decrement);
}
  next(action);
  if (action == Action.decrement) {
     await Future.delayed(Duration(seconds: 3),(){
       store.dispatch(Action.decrement);
    //   print('secondes action => incremente');
     });
  
  }
    
}