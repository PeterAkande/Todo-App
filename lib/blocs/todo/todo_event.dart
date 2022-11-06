part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodo extends TodoEvent {}

class DeleteTodo extends TodoEvent {
  const DeleteTodo(this.title) : super();

  final String title;
}
