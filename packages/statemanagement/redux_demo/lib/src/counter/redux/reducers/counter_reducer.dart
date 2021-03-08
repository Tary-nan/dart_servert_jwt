import 'package:redux_demo/src/counter/redux/actions/counter_action.dart';

int counterReducer(int state, action) {
  if (action == Action.increment) {
    return state + 1;
  } else if (action == Action.decrement) {
    return state - 1;
  }
  return state;
}
