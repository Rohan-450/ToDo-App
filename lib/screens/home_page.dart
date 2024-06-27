import 'package:flutter/material.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/screens/addtask_page.dart';
import '../constants/colors.dart';
import '../utils/todo.dart';
import '../utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //final _myBox = Hive.box('mybox');
  //ToDoDataBase db =ToDoDataBase();

  final todosList=ToDo.toDoList();
  List<ToDo> searchList = [];

 /* void createInitialData(){
    ToDo(
        id: "1",
        taskName: "Create First Task",
        taskCompleted: false,
      );
  }
  void loadData(){
    todosList = _myBox.get('TODOS');
  }
  void updateData(){
    _myBox.put('TODOS', todosList);
  }*/

  @override
  void initState() {
    /*if(_myBox.get('TODOS') == null){
      createInitialData();
    }else{
      loadData();
    }*/
    searchList = todosList;
    super.initState();
  }
  
  void checkBoxChanged(ToDo todo){
    setState(() {
      todo.taskCompleted = !todo.taskCompleted!;
    });
    //updateData();
  }

  void deleteTask(String id){
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
    //updateData();
  }

  void searchTask(String query){
    List<ToDo> results = [];
    results = todosList.where((element) => element.taskName!.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      searchList = results;
    });
  }

   void addTask(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        taskName: toDo,
      ),
      );
    });
    //updateData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 18,),
              decoration: const BoxDecoration(
                color: tBgColor,
              ),
              child: Column(
                children:[
                    searchBox(),
                    Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 25,),
                      child: const Text("All Tasks", 
                      style: TextStyle(
                        color: tBlack, 
                        fontSize: 30, 
                        fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    ),
                 ]
               ),
            ),
            
            Expanded(
              child: ListView(
                children:[
                  for( ToDo todoo in searchList.reversed)
                    ToDoTile(
                      todo: todoo,
                      onChanged: checkBoxChanged,
                      onDelete: deleteTask,),
                ]
              )
            ),
        ],)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
           var result= await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddTaskPage()),
            );
            if(result!=null){
              addTask(result);
            }
          },
        backgroundColor: tBlue,
        elevation: 5.0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size:30, color: Colors.white,),
      ),
    );
  }

  Widget searchBox(){
    return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                  onChanged: (value) => searchTask(value),
                  decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search, color: tBlack,size: 25,),
                  prefixIconConstraints: BoxConstraints(minWidth: 25, maxHeight: 20),
                  hintText: " Search",
                  hintStyle: TextStyle(color: tGrey, fontSize: 20),
                  border: InputBorder.none,
                ),
              ),
            );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tBgColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        const Icon(Icons.menu, color: tBlack, size:30,),
        const Text("ToDo Lists", style: TextStyle(color: tBlack, fontWeight: FontWeight.bold),),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset("assets/avatar.jpg", fit: BoxFit.cover,),
          )
        )
      ],)
    );
  }
}