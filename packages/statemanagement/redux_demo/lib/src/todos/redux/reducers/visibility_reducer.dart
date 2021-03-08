import 'package:redux/redux.dart';
import 'package:redux_demo/redux_demo.dart';
import 'package:redux_demo/src/todos/redux/actions/visibility_action.dart';

Reducer<VisibilityFilter> visibilityReducer =
    combineReducers<VisibilityFilter>([
  TypedReducer<VisibilityFilter, SetVisibilityFilterAction>(showVisibility),
]);

VisibilityFilter showVisibility(
    VisibilityFilter state, SetVisibilityFilterAction action) {
  return action.filter;
}
