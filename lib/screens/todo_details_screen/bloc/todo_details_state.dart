part of 'todo_details_bloc.dart';

abstract class TodoDetailsState extends Equatable {
  const TodoDetailsState();

  @override
  List<Object> get props => [];
}

class TodoDetailsInitial extends TodoDetailsState {}

class EditingTodoDetailsState extends TodoDetailsState {
  final TodoModel todoModel;

  const EditingTodoDetailsState(this.todoModel);
//This is the details when a _todo details is being edited
}

class AddingNewTodoDetailsState extends TodoDetailsState {
  //This is the stat when a new _todo is being created
}

class ViewingTodoDetailsState extends TodoDetailsState {
  //This is the event that would be when a _todo details is being viewed
  final TodoModel todoModel;

  const ViewingTodoDetailsState(this.todoModel);
}
