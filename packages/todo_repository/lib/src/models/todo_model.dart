//This would contain the todos config variables
class TodoModel {
  TodoModel(
      {required this.title,
      required this.id,
      required this.completed,
      required this.dateCompleted,
      required this.dateCreated,
      required this.additionalContents});

  String id;
  String title;
  String additionalContents;
  DateTime dateCompleted;
  DateTime dateCreated;
  bool completed;
}
