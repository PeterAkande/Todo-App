import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_repository/todo_repository.dart';

import '../../../routers/cubit/todo_app_cubit.dart';

part 'todo_details_event.dart';
part 'todo_details_state.dart';

class TodoDetailsBloc extends Bloc<TodoDetailsEvent, TodoDetailsState> {
  final TodoAppCubit _appState;

  TodoDetailsBloc(this._appState) : super(TodoDetailsInitial()) {
    on<TodoDetailsSubscriptionRequested>(_onTodoDetailsSubscriptionRequested);
    on<TodoDetailsEvent>((event, emit) {});
    on<EditTodoDetailsRequested>(_onEditTodoDetailsRequested);
  }

  _onTodoDetailsSubscriptionRequested(
      TodoDetailsSubscriptionRequested event, Emitter emit) {
    emit.forEach(_appState.stream, onData: (TodoAppState appState) {
      if (appState.addOrEditingATodo) {
        //A _todo is to be created or is being edited
        if (appState.selectedTodo != null) {
          //The selected _todo is not null. Therefore add a previous _todo is being edited

          emit(EditingTodoDetailsState(appState.selectedTodo!));
        } else {
          //A new _todo is to be created;
          emit(AddingNewTodoDetailsState());
        }
      }
    });
  }

  _onEditTodoDetailsRequested(EditTodoDetailsRequested event, Emitter emit) {
    emit(EditingTodoDetailsState(event.todo));
  }
}
