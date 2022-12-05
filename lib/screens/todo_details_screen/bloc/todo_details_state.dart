part of 'todo_details_bloc.dart';

abstract class TodoDetailsState extends Equatable {
  const TodoDetailsState();
}

class TodoDetailsInitial extends TodoDetailsState {
  @override
  List<Object> get props => [];
}
