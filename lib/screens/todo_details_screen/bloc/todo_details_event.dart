part of 'todo_details_bloc.dart';

abstract class TodoDetailsEvent {
  const TodoDetailsEvent();
}

class TodoDetailsSubscriptionRequested extends TodoDetailsEvent {}

class EditTodoDetailsRequested extends TodoDetailsEvent {
  //This is the event that would be emitted when a _todo details is to edited

  final TodoModel todo;

  const EditTodoDetailsRequested(this.todo);
}

class AddNewTodoDetailsRequested extends TodoDetailsEvent {
  //This is when a new _todo details is to be added.
}

class SaveTodoDetailRequested extends TodoDetailsEvent {
  TodoModel?
      todoModel; // This is nullable. If it is null, a new _todo is being saved
  String title;
  String content;

  bool completed;

  SaveTodoDetailRequested(
      {this.todoModel,
      required this.content,
      required this.title,
      required this.completed});
}

class ViewTodoDetailsRequested extends TodoDetailsEvent {
  //This is when the details of a _todo is to be viewed. No editing of the todo is allowed here.

  final TodoModel todo;

  const ViewTodoDetailsRequested(this.todo);
}
