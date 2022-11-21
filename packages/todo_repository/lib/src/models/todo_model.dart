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

  static TodoModel fromJson(Map<String, dynamic> data) {
    String id = data['id'];
    String title = data['title'];
    String additionalContents = data['additionalContents'];
    DateTime dateCompleted = data['dateCompleted'];
    DateTime dateCreated = data['dateCreated'];
    bool completed = data['completed'];

    return TodoModel(
        title: title,
        id: id,
        completed: completed,
        dateCompleted: dateCompleted,
        dateCreated: dateCreated,
        additionalContents: additionalContents);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'completed': completed,
      'dateCompleted': dateCompleted,
      'additionalContents': additionalContents,
      'dateCreated': dateCreated
    };
  }
}
