part of 'todo_app_cubit.dart';

class TodoAppState extends Equatable {
  //The selectedTodo can be null. If it isn't null, the details screen would be shown. with the selected _todo
  //details shown.
  //If the addOrEditingATodo is true, it means that a todo is to be added or edited. If it is to be added.
  //Or edited depends on the value of selectedTodo

  TodoModel? selectedTodo;
  bool addOrEditingATodo;

  TodoAppState({this.selectedTodo, this.addOrEditingATodo = false});

  @override
  List<Object?> get props => [selectedTodo, addOrEditingATodo];
}
