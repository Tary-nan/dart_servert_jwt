import 'package:redux/redux.dart';

loggingMiddleware(Store<int> store, action, NextDispatcher next) {
  print('${new DateTime.now()}: $action');

  next(action);
}