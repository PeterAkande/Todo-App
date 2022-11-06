part of 'todo_bloc.dart';

class TodoState extends Equatable {
  const TodoState(this.todos);

  final List<TodoModel> todos;

  @override
  List get props => [todos]; //If todos is changes, a rebuild is triggered
}
