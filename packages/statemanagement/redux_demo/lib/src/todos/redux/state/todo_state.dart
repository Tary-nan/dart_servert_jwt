enum VisibilityFilter { SHOW_ALL, SHOW_ACTIVE, SHOW_COMPLETED }

class TodoState {
   List<Todo> todos;
   VisibilityFilter visibilityFilter;
   bool isFetching;
   Exception error;

   TodoState({
    this.todos = const [],
    this.visibilityFilter,
    this.error,
    this.isFetching = false
  });

  TodoState.initialState() : todos = <Todo>[],
  isFetching = false,
  error = null,
  visibilityFilter = VisibilityFilter.SHOW_ALL;
}

class Todo {
  final int id;
  final String text;
  final bool completed;

  const Todo({
    this.id,
    this.text,
    this.completed = false,
  });

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
