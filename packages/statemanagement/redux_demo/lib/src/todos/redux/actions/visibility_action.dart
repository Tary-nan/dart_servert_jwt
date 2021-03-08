import 'package:redux_demo/src/todos/redux/state/todo_state.dart';

class SetVisibilityFilterAction{
  final VisibilityFilter filter;
  SetVisibilityFilterAction({this.filter});
}