part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class TodoSubscriptionRequested extends TodoEvent {}

class TodoAdded extends TodoEvent {
  const TodoAdded({required this.title, required this.additionalContents})
      : super();
  final String title;
  final String additionalContents;
}

class TodoUpdated extends TodoEvent {
  const TodoUpdated({required this.id, required this.updatedTodo}) : super();

  final String id;
  final TodoModel updatedTodo;
}

class TodoDeleted extends TodoEvent {
  const TodoDeleted(this.id) : super();

  // final String title;
  final String id;
}
