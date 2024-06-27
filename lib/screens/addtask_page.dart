import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/todo.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _taskController = TextEditingController();
  
  final addList=ToDo.toDoList();

  
  void addTask(String toDo) {
    setState(() {
      addList.add(ToDo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        taskName: toDo,
      ),
      );
    });
    _taskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: AppBar(
        title: const Text('Add Task'),
        backgroundColor: tBgColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                bottom: 25,
              ),
              child: const Text(
                "Add your Tasks",
                style: TextStyle(
                    color: tBlack, fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height:20),
            TextFormField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'New Task',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width:100,
                  height:45,
                  child: ElevatedButton(
                    onPressed: () {
                      addTask(_taskController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tBlue,
                    ),
                    child: const Text('Add', 
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
                  ),
                ),
                SizedBox(
                  width:100,
                  height:45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}
