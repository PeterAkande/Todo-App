import 'package:todos_database_hive/todos_database_hive.dart';

import '../todo_repository.dart';

class TodoRepository {
  //This class would be responsible for doing the CRUD processes on a _Todo

  DatabaseOperations databaseOperations = HiveDbOperations();

  Future<TodoModel?> getTodo(String id) async {
    Map<String, dynamic> todo = await databaseOperations.getTodo(id);

    return todo.isEmpty ? null : TodoModel.fromJson(todo);
  }

  Stream<List<TodoModel>> getAllTodos() async* {
    //So in this function, transform the Json stream from the _todo database and
    //return it as as a _todo stream

    yield* databaseOperations.getTodos().map<List<TodoModel>>(
      (todoModelsJsonSchemas) {
        List<TodoModel> todoModels = [];

        todoModelsJsonSchemas.forEach(
          (todoJsonSchema) {
            todoModels.add(TodoModel.fromJson(todoJsonSchema));
          },
        );

        return todoModels;
      },
    );
  }

  Future<TodoModel?> updateTodo(String id, TodoModel updatedTodo) async {
    Map<String, dynamic> updatedTodoSchema =
        await databaseOperations.updateTodo(id, updatedTodo);

    return updatedTodoSchema.isEmpty
        ? null
        : TodoModel.fromJson(updatedTodoSchema);
  }

  Future<bool> deleteTodo(String id) async {
    final operationSuccessful = await databaseOperations.deleteTodo(id);

    return operationSuccessful;
  }

  Future<Map<String, dynamic>> createTodo(
      String title, String additionalContents) async {
    Map<String, dynamic> todoSchema = await databaseOperations.createTodo(
        title: title, additionalContents: additionalContents);

    return todoSchema;
  }
}
