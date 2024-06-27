class ToDo{
  String? id;
  String? taskName;
  bool? taskCompleted;

  ToDo({
  required this.id,
  required this.taskName,
  this.taskCompleted = false,
});

  static List<ToDo> toDoList(){
    return [
      ToDo(
        id: "1",
        taskName: "Create First Task",
        taskCompleted: false,
      ),
    ];
  }
}



