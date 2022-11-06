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

  Todo({
    required this.title,
    required this.completed,
    required this.dateCompleted,
    required this.dateCreated,
    required this.additionalContents,
  }) : super(
            additionalContents: additionalContents,
            title: title,
            dateCompleted: dateCompleted,
            dateCreated: dateCompleted,
            completed: completed);
}
