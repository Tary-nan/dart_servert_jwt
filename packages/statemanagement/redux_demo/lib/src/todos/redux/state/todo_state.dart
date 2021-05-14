import 'package:redux_demo/src/databasse/database.dart';

enum VisibilityFilter { SHOW_ALL, SHOW_ACTIVE, SHOW_COMPLETED }

class TodoState {
   List<Todo> todos;
   VisibilityFilter visibilityFilter;
   bool isFetching;
   Exception error;
   DB database;

   TodoState({
    this.todos = const [],
    this.visibilityFilter,
    this.error,
    this.isFetching = false,
    this.database
  });

  TodoState.initialState() : todos = <Todo>[],
  isFetching = false,
  error = null,
  visibilityFilter = VisibilityFilter.SHOW_ALL;
}

class Todo {
  final String id;
  final String text;
  final bool completed;

  const Todo({
    this.id,
    this.text,
    this.completed = false,
  });

  factory Todo.fromJson(Map json){
    return Todo(
      id: DateTime.now().toString(),
      text: json['text'],
      completed : false
    );
  }

  Map<String, dynamic> toJson()=>{
      'id': id,
      'text': text,
      'completed': completed
  };

  Todo copyWith({int id, String text, bool completed}) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      completed: completed ?? this.completed,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          completed == other.completed;

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ completed.hashCode;
}
