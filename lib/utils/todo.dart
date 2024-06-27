//import 'package:hive_flutter/hive_flutter.dart';

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

/*class ToDoDataBase{
  final _myBox = Hive.box('mybox');
  static List<ToDo> toDoList=[];
  void createInitialData(){
    ToDo(
        id: "1",
        taskName: "Create First Task",
        taskCompleted: false,
      );
  }

  void loadData(){
    toDoList = _myBox.get('TODOS');
  }

  void updateData(){
    _myBox.put('TODOS', toDoList);
  }
}*/


