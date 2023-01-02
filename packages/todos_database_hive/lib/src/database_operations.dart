import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_repository/todo_repository.dart';
import 'package:todos_database_hive/src/db_config/db_config.dart';
import 'package:todos_database_hive/src/util_functions.dart';

import 'db_config/todos_db_config.dart';

class HiveDbOperations extends DatabaseOperations {
  //This class would handle the getting of the data from the hive database

  late Box<Todo> box;

  init() async {
    Hive.registerAdapter(TodoAdapter());
    await Hive.initFlutter().then((value) async {
      box = await Hive.openBox(todoBoxName);
      todosStream.add(_getAllTodos()); //Add the todos to the stream
    });
  }

  //A BehaviourSubject stream is used and not just a stream controller is because
  //For a BehaviourSubject, the last stream event is broadcast to any new listener
  final BehaviorSubject<ListOfTodos> todosStream = BehaviorSubject.seeded([]);

  Stream<ListOfTodos> getTodos() => todosStream.asBroadcastStream();

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

    await box.put(id, Todo.fromTodoModel(todoModel)).then((value) {
      //Add the newly added _todo to the todos list then broadcast the new list of todos

      final newTodos = [...todosStream.value];
      newTodos.add(todoModel.toJson());
      todosStream.add(newTodos);

      //This is a closure, so using a completer is the best approach.
      //Dependable :)
      createTodoCompleter.complete(todoModel.toJson());
    }, onError: (error) {});

    return createTodoCompleter.future;
  }

  Future<Map<String, dynamic>> getTodo(String id) async {
    //This would return a _todo if it exits else, an empty Map

    TodoModel? todoModel = box.get(id);

    return todoModel != null ? todoModel.toJson() : {};
  }

  ListOfTodos _getAllTodos() {
    //This function would get all the todos stored in the database.

    ListOfTodos allTodos = [];

    box.values.forEach((todo) {
      allTodos.add(todo.toJson());
    });

    return allTodos;
  }

  // Future<Map<String, dynamic>> updateTodo(String id,
  //     {String? title,
  //     DateTime? dateCompleted,
  //     bool? completed,
  //     String? additionalContents}) async {
  //   //This function updates a _todo in te database
  //
  //   TodoModel? todo = box.get(id);
  //
  //   if (todo == null) return {};
  //
  //   final allTodos = [...todosStream.value];
  //
  //   //Get the index of this current _todo
  //   final int todoIndex =
  //       allTodos.indexWhere((jsonSchema) => jsonSchema['id'] == id);
  //
  //   //Update the fields accordingly
  //   todo.dateCompleted = dateCompleted ?? todo.dateCompleted;
  //   todo.completed = completed ?? todo.completed;
  //   todo.additionalContents = additionalContents ?? todo.additionalContents;
  //   todo.title = title ?? todo.title;
  //
  //   await box.put(id, todo);
  //
  //   allTodos[todoIndex] = todo.toJson();
  //   return todo.toJson();
  // }

  Future<Map<String, dynamic>> updateTodo(
      String id, TodoModel updatedTodoModel) async {
    //This function updates a _todo in te database

    TodoModel? todo = box.get(id);

    if (todo == null) return {};

    final allTodos = [...todosStream.value];

    //Get the index of this current _todo
    final int todoIndex =
        allTodos.indexWhere((jsonSchema) => jsonSchema['id'] == id);

    await box
        .put(id, Todo.fromTodoModel(updatedTodoModel))
        .then((value) {}, onError: (error) {});

    allTodos[todoIndex] = updatedTodoModel.toJson();
    todosStream.add(allTodos);
    return updatedTodoModel.toJson();
  }

  Future<bool> deleteTodo(String id) async {
    //This would delete a particular _todo from the database.
    //Would return true if the process was successful otherwise, false
    Completer<bool> deletedCompleter = Completer();

    //Get all the todos.
    final allTodos = [...todosStream.value];

    await box.delete(id).then((value) {
      //Update the todos and pass it to the stream
      allTodos.removeWhere((todoJsonSchema) => todoJsonSchema['id'] == id);
      todosStream.add(allTodos);

      //Mark the process as complete
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

    await box.clear().then((value) {
      //Pass the updated list of todos
      todosStream.add([]);

      //Mark the operation as completed
      deletedCompleter.complete(true);
    }, onError: (error) {
      deletedCompleter.complete(false);
    });
    return deletedCompleter.future;
  }
}
