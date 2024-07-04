import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/utils/todo.dart';

class HiveDB {
  final _myBox = Hive.box('mybox');
  List<ToDo> getTodos() {
    var values = _myBox.values.map((e) => ToDo.fromJson(e)).toList();
    return values;
  }

  Future<void> updateTaskDb(ToDo todo) async {
    await _myBox.put(todo.id, todo.toJson());
  }

  Future<void> deleteTaskDb(String id) async {
    await _myBox.delete(id);
  }

  Future<void> addTaskDb(ToDo todo) async {
    await _myBox.put(todo.id, todo.toJson());
  }
}
