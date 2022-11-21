typedef ListOfTodos = List<Map<String, dynamic>>;

abstract class DatabaseOperations {
  Future<Map<String, dynamic>> createTodo(
      {required String title, required String additionalContents});

  Future<Map<String, dynamic>> getTodo(String id);

  Future<Map<String, dynamic>> updateTodo(String id,
      {String? title,
      DateTime? dateCompleted,
      bool? completed,
      String? additionalContents});

  Stream<ListOfTodos> getTodos();

  Future<bool> deleteTodo(String id);

  Future<bool> deleteAllTodo(String id);
}
