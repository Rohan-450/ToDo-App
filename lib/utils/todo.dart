class ToDo {
  String? id;
  String? taskName;
  bool? taskCompleted;

  ToDo({
    required this.id,
    required this.taskName,
    this.taskCompleted = false,
  });

  static List<ToDo> toDoList() {
    return [];
  }

  factory ToDo.fromJson(Map<dynamic, dynamic> json) {
    return ToDo(
      id: json['id'],
      taskName: json['taskName'],
      taskCompleted: json['taskCompleted'],
    );
  }
  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'taskName': taskName,
      'taskCompleted': taskCompleted,
    };
  }
}
