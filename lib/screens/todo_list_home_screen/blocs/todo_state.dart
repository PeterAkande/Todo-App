part of 'todo_bloc.dart';

enum TodoStatus { loading, success, failure }

class TodoState extends Equatable {
  const TodoState({this.todos = const [], this.status = TodoStatus.loading});

  final List<TodoModel> todos;
  final TodoStatus status;

  TodoState copyWith(
      {TodoStatus Function()? currentStatus,
      List<TodoModel> Function()? allTodos}) {
    return TodoState(
        todos: allTodos != null ? allTodos() : todos,
        status: currentStatus != null ? currentStatus() : status);
  }

  @override
  List get props =>
      [todos, status]; //If todos is changes, a rebuild is triggered
}
