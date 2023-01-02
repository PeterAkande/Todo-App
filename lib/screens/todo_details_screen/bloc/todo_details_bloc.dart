import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_repository/todo_repository.dart';

import '../../../routers/cubit/todo_app_cubit.dart';

part 'todo_details_event.dart';
part 'todo_details_state.dart';

class TodoDetailsBloc extends Bloc<TodoDetailsEvent, TodoDetailsState> {
  final TodoAppCubit _appState;
  final TodoRepository _todoRepository;

  TodoDetailsBloc(this._appState, this._todoRepository)
      : super(TodoDetailsState()) {
    on<TodoDetailsSubscriptionRequested>(_onTodoDetailsSubscriptionRequested);
    on<EditTodoDetailsRequested>(_onEditTodoDetailsRequested);
    on<AddNewTodoDetailsRequested>(_onAddNewTodoDetailsRequested);
    on<SaveTodoDetailRequested>(_onSaveTodoDetailRequested);
    on<ViewTodoDetailsRequested>(_onViewTodoDetailsRequested);
  }

  Future<void> _onTodoDetailsSubscriptionRequested(
      TodoDetailsSubscriptionRequested event, Emitter emit) async {
    await emit.forEach(_appState.stream, onData: (TodoAppState appState) {
      if (!appState.addOrEditingATodo && appState.selectedTodo == null) {
        return state.copyWith(
            newTodoCallback: () => null, addOrEditTodoCallback: () => false);
      }
      if (appState.selectedTodo != null) {
        //The selected _todo is not null. Therefore a previous _todo is being edited

        return state.copyWith(
            newTodoCallback: () => appState.selectedTodo!,
            addOrEditTodoCallback: () => false);
      } else {
        //A new _todo is to be created;
        return state.copyWith(
            newTodoCallback: () => null, addOrEditTodoCallback: () => true);
      }
    });
  }

  Future<void> _onEditTodoDetailsRequested(
      EditTodoDetailsRequested event, Emitter<TodoDetailsState> emit) async {
    emit(state.copyWith(
        newTodoCallback: () => event.todo, addOrEditTodoCallback: () => true));
  }

  Future<void> _onAddNewTodoDetailsRequested(
      AddNewTodoDetailsRequested event, Emitter<TodoDetailsState> emit) async {
    //This function would be called when a new _todo is to be added.
    //It emits a state with selectedTodo as null and the addingNewTodo as true

    emit(state.copyWith(
        newTodoCallback: () => null, addOrEditTodoCallback: () => true));
  }

  Future<void> _onSaveTodoDetailRequested(
      SaveTodoDetailRequested event, Emitter<TodoDetailsState> emit) async {
    if (event.todoModel != null) {
      //A _todo is to be updated.
      //After the _todo is saved, emit the state with selected _todo and the addingOrEditing as false

      event.todoModel!.title = event.title;
      event.todoModel!.completed = event.completed;
      event.todoModel!.additionalContents = event.content;

      TodoModel? updatedTodo = await _todoRepository.updateTodo(
          event.todoModel!.id, event.todoModel!);

      if (updatedTodo == null) {
        return;
      }

      emit(state.copyWith(
          newTodoCallback: () => updatedTodo,
          addOrEditTodoCallback: () => false));
    } else {
      //A _todo is to be updated;
      TodoModel newTodo =
          await _todoRepository.createTodo(event.title, event.content);

      emit(state.copyWith(
          newTodoCallback: () => newTodo, addOrEditTodoCallback: () => false));
    }
  }

  FutureOr<void> _onViewTodoDetailsRequested(
      ViewTodoDetailsRequested event, Emitter<TodoDetailsState> emit) {
    emit(state.copyWith(
        newTodoCallback: () => event.todo, addOrEditTodoCallback: () => false));
  }
}
