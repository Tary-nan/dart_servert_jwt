import 'dart:async';

import 'package:redux/redux.dart';
import 'package:redux_demo/redux_demo.dart';
import 'package:redux_demo/src/counter/counter_app.dart';
import 'package:redux_demo/src/todos/redux/actions/add_todo_action.dart';
import 'package:redux_demo/src/todos/redux/actions/remove_todo_action.dart';
import 'package:redux_demo/src/todos/redux/actions/toggle_action.dart';
import 'package:redux_demo/src/todos/redux/actions/update_todo_action.dart';
import 'package:redux_demo/src/todos/redux/actions/visibility_action.dart';

class TodosApp implements Manager {
  final Store<TodoState> _store;
  TodosApp(this._store);

  StreamSubscription<TodoState> streamSubscription;

  void add(String id, String text) {
    _store.dispatch(AddTodoAction(id, text));
  }

  void remove(String id) {
    _store.dispatch(RemoveTodoAction(id));
  }

  void toggle(String id) {
    _store.dispatch(ToggleTodoAction(id: id));
  }

  void visibilty(VisibilityFilter filter) {
    _store.dispatch(SetVisibilityFilterAction(filter: filter));
  }

  void update(String id, Todo todo) {
    _store.dispatch(UpdateTodoAction(id, todo));
  }

  void storeState(TodoState curentState) {
    print('curent state');
    curentState.todos
        .forEach((element) => print('ok ${element.id} :  ${element.text}'));
  }

  void listen() {
    streamSubscription = _store.onChange.listen(
      (value) {
        print(value.todos);
      },
    );
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
  }
}
