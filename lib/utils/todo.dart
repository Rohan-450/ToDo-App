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
        taskName: "Do yoga",
        taskCompleted: false,
      ),
      ToDo(
        id: "2",
        taskName: "Buy meats",
        taskCompleted: true,
      ),
      ToDo(
        id: "3",
        taskName: "Do Homework",
        taskCompleted: true,
      ),
      ToDo(
        id: "4",
        taskName: "Team Meeting",
        taskCompleted: true,
      ),
      ToDo(
        id: "5",
        taskName: "Dinner",
        taskCompleted: false,
      ),
    ];
  }
}



