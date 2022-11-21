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

  Future<TodoModel?> updateTodo(String id,
      {String? title,
      DateTime? dateCompleted,
      bool? completed,
      String? additionalContents}) async {
    Map<String, dynamic> updatedTodo = await databaseOperations.updateTodo(id,
        title: title,
        dateCompleted: dateCompleted,
        completed: completed,
        additionalContents: additionalContents);

    return updatedTodo.isEmpty ? null : TodoModel.fromJson(updatedTodo);
  }
}
