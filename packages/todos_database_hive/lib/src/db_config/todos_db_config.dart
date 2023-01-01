import 'package:hive/hive.dart';
import 'package:todo_repository/todo_repository.dart';

part 'todos_db_config.g.dart';

@HiveType(typeId: 0)
class Todo extends TodoModel {
  //Add dependency on the TodoModel defined in the repository.
  //This is to ensure consistency. So that if a new field is added in the todos model, this would
  //Also need to be changed.

  @HiveField(0)
  String title;
  @HiveField(1)
  bool completed;
  @HiveField(2)
  DateTime dateCompleted;
  @HiveField(3)
  String additionalContents;
  @HiveField(4)
  DateTime dateCreated;
  @HiveField(5)
  String
      id; //This would be the id of the todo_. Instead of using the title as a placeholder

  Todo({
    required this.title,
    required this.completed,
    required this.dateCompleted,
    required this.id,
    required this.dateCreated,
    required this.additionalContents,
  }) : super(
            additionalContents: additionalContents,
            title: title,
            id: id,
            dateCompleted: dateCompleted,
            dateCreated: dateCompleted,
            completed: completed);

  factory Todo.fromTodoModel(TodoModel todoModel) {
    //This is needed since only a model of type _todo can be stored in the
    //Hive Db

    return Todo(
        title: todoModel.title,
        completed: todoModel.completed,
        dateCompleted: todoModel.dateCompleted,
        id: todoModel.id,
        dateCreated: todoModel.dateCreated,
        additionalContents: todoModel.additionalContents);
  }
}
