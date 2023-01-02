import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_repository/todo_repository.dart';

part 'todo_app_state.dart';

class TodoAppCubit extends Cubit<TodoAppState> {
  TodoAppCubit() : super(TodoAppState());

  void selectTodo(TodoModel todoModel) {
    emit(TodoAppState(selectedTodo: todoModel));
  }

  void createNewTodo() {
    emit(TodoAppState(addOrEditingATodo: true));
  }

  void unSelectTodo() {
    emit(TodoAppState());
  }
}
