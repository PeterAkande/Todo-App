part of 'todo_details_bloc.dart';

class TodoDetailsState extends Equatable {
  TodoDetailsState({this.todo, this.addingNewTodo = false});

  TodoModel? todo;
  bool addingNewTodo;

  //Cant use a factory method here since i would need to access instance members
  TodoDetailsState copyWith(
      {TodoModel? Function()? newTodo, bool Function()? addNewTodo}) {
    return TodoDetailsState(
        todo: newTodo != null ? newTodo() : todo,
        addingNewTodo: addNewTodo != null ? addNewTodo() : addingNewTodo);
  }

  @override
  List<Object> get props => [];
}
