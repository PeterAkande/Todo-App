import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_repository/todo_repository.dart';

part 'todo_app_state.dart';

class TodoAppCubit extends Cubit<TodoAppState> {
  TodoAppCubit() : super(TodoAppState());
}
