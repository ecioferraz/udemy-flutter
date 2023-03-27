class Todo {
  Todo({required this.dateTime, required this.task});

  Todo.fromJson(Map<String, dynamic> json)
      : task = json['task'],
        dateTime = DateTime.parse(json['datetime']);

  String task;
  DateTime dateTime;

  Map<String, dynamic> toJson() {
    return {
      'task': task,
      'datetime': dateTime.toIso8601String(),
    };
  }
}
