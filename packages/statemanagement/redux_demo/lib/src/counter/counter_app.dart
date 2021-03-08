import 'dart:async';

import 'package:redux/redux.dart';
import 'package:redux_demo/src/counter/redux/actions/counter_action.dart';

class CounterApp implements Manager {
  final Store<int> _store;
  CounterApp(this._store);

  StreamSubscription<int> streamSubscription;

  void increment() {
    _store.dispatch(Action.increment);
  }

  void decrement() {
    _store.dispatch(Action.decrement);
  }

  void storeState(int curentState) {
    print('curent state');
    print(curentState);
  }

  void listen() {
    streamSubscription = _store.onChange.listen((value) {
      print(value);
    });
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
  }
}

abstract class Manager {
  void dispose();
}
