import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_repository/todo_repository.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  late final TodoRepository _todoRepository;

  TodoBloc(TodoRepository todoRepository)
      : _todoRepository = todoRepository,
        super(const TodoState()) {
    on<TodoSubscriptionRequested>(_todoSubscriptionRequested);
    on<TodoDeleted>(_onTodoDeleted);
    on<TodoUpdated>(_onTodoUpdated);
    on<TodoAdded>(_onTodoAdded);
  }

  _todoSubscriptionRequested(
      TodoSubscriptionRequested event, Emitter<TodoState> emit) async {
    //Here, this bloc would subscribe to the todos stream

    emit(state.copyWith(currentStatus: () => TodoStatus.loading));

    await emit.forEach<List<TodoModel>>(_todoRepository.getAllTodos(),
        onData: (todos) {
      return state.copyWith(
          allTodos: () => todos, currentStatus: () => TodoStatus.success);
    });
  }

  _onTodoDeleted(TodoDeleted event, Emitter<TodoState> emit) async {
    await _todoRepository.deleteTodo(event.id);
  }

  _onTodoUpdated(TodoUpdated event, Emitter<TodoState> emit) async {
    await _todoRepository.updateTodo(event.id, event.updatedTodo);
  }

  _onTodoAdded(TodoAdded event, Emitter<TodoState> emit) async {
    await _todoRepository.createTodo(event.title, event.additionalContents);
  }
}
