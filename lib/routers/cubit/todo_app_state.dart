part of 'todo_app_cubit.dart';

class TodoAppState extends Equatable {
  TodoModel? selectedTodo; //This can be null.
  TodoAppState({TodoModel? selectedTodo});

  @override
  List<Object?> get props => [selectedTodo];
}
