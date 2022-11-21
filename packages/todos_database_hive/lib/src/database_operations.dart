import 'dart:async';

import 'package:hive/hive.dart';
import 'package:todo_repository/todo_repository.dart';
import 'package:todos_database_hive/src/db_config/constants.dart';
import 'package:todos_database_hive/src/util_functions.dart';


class HiveDbOperations extends DatabaseOperations{
  //This class would handle the getting of the data from the hove database

  late Box<TodoModel> box;

  DbOperations() {
    Hive.openBox(todoBoxName).then((value) {
      box = Hive.box<TodoModel>(todoBoxName);
    }); //Open the box and assign the box to the box class.
  }

  Future<Map<String, dynamic>> createTodo(
      {required String title, required String additionalContents}) async {
    //This would create a _todo in the database and return the json representation of the _todo.
    //The reason why a JSON is returned and not just the normal TodoModel object is
    //To ensure flexibility in the system.
    //So.. any Database source apart from Hive can be used.

    String id = createRandomId();
    DateTime dateCreated = DateTime.now();
    DateTime dateCompleted =
        DateTime.now(); // Just to have something there in the db.

    TodoModel todoModel = TodoModel(
        title: title,
        id: id,
        completed: false,
        dateCompleted: dateCompleted,
        dateCreated: dateCreated,
        additionalContents: additionalContents);

    Completer<Map<String, dynamic>> createTodoCompleter = Completer();

    box.put(id, todoModel).then((value) {
      //This is a closure, so using a completer is the best approach.
      //Dependable :)

      createTodoCompleter.complete(todoModel.toJson());
    });

    return createTodoCompleter.future;
  }

  Future<Map<String, dynamic>> getTodo(String id) async {
    //This would return a _todo if it exits else, an empty Map

    TodoModel? todoModel = box.get(id);

    return todoModel != null ? todoModel.toJson() : {};
  }

  Future<Map<String, dynamic>> updateTodo(String id,
      {String? title,
      DateTime? dateCompleted,
      bool? completed,
      String? additionalContents}) async {
    //This function updates a _todo in te database

    TodoModel? todo = box.get(id);

    if (todo == null) return {};

    todo.dateCompleted = dateCompleted ?? todo.dateCompleted;
    todo.completed = completed ?? todo.completed;
    todo.additionalContents = additionalContents ?? todo.additionalContents;
    todo.title = title ?? todo.title;


    await box.put(id, todo);
    return todo.toJson();

  }

  Future<ListOfTodos> getAllTodos() async {
    //This function would get all the todos stored in the database.
    //Need for it to be a future???.
    //Well for flexibility,lets leave it as such

    ListOfTodos allTodos = [];

    box.values.forEach((todo) {
      allTodos.add(todo.toJson());
    });

    return allTodos;
  }

  Future<bool> deleteTodo(String id) async {
    //This would delete a particular _todo from the database.
    //Would return true if the process was successful otherwise, false
    Completer<bool> deletedCompleter = Completer();

    box.delete(id).then((value) {
      deletedCompleter.complete(true);
    }, onError: (error) {
      deletedCompleter.complete(false);
    });
    return deletedCompleter.future;
  }

  Future<bool> deleteAllTodo(String id) async {
    //This would delete all _todos from the database.
    //Would return true if the process was successful otherwise, false
    Completer<bool> deletedCompleter = Completer();

    box.clear().then((value) {
      deletedCompleter.complete(true);
    }, onError: (error) {
      deletedCompleter.complete(false);
    });
    return deletedCompleter.future;
  }
}
