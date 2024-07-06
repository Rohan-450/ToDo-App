// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../utils/todo.dart';
import '../constants/colors.dart';

class ToDoTile extends StatelessWidget {
  final ToDo todo;
  final onChanged;
  final onDelete;
  const ToDoTile({super.key, required this.todo, required this.onChanged, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap:(){
          onChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Theme.of(context).colorScheme.primary,
        leading: Icon(todo.taskCompleted! ? Icons.check_box : Icons.check_box_outline_blank, color: tBlue),
        title: Text(todo.taskName!, 
              style: TextStyle(
                color:tBlack, 
                fontSize: 20, 
                fontWeight: FontWeight.w500,
                decoration: todo.taskCompleted! ? TextDecoration.lineThrough : null
              ),
            ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: tRed,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 22,
            icon: const Icon(Icons.delete),
            onPressed: (){
              onDelete(todo.id);
            },
          ),
        )
      )
    );
  }
}