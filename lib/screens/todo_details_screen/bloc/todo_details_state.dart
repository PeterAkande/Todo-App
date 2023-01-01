part of 'todo_details_bloc.dart';

class TodoDetailsState extends Equatable {
  TodoDetailsState({this.todo, this.addingOrEditingTodo = false});

  TodoModel? todo;
  bool addingOrEditingTodo;

  //Cant use a factory method here since i would need to access instance members
  TodoDetailsState copyWith(
      {TodoModel? Function()? newTodoCallback,
      bool Function()? addOrEditTodoCallback}) {
    return TodoDetailsState(
        todo: newTodoCallback != null ? newTodoCallback() : todo,
        addingOrEditingTodo: addOrEditTodoCallback != null
            ? addOrEditTodoCallback()
            : addingOrEditingTodo);
  }

  @override
  List<Object> get props => [];
}
