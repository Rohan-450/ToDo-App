import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/screens/addtask_page.dart';
import '../constants/colors.dart';
import '../utils/database.dart';
import '../utils/todo.dart';
import '../utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDo> todosList = [];
  List<ToDo> searchList = [];

  HiveDB db = HiveDB();

  @override
  void initState() {
    todosList = db.getTodos();
    searchList = todosList;
    super.initState();
  }

  void checkBoxChanged(ToDo todo) {
    setState(() {
      todo.taskCompleted = !todo.taskCompleted!;
    });
    db.updateTaskDb(todo);
  }

  void deleteTask(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
    db.deleteTaskDb(id);
  }

  void searchTask(String query) {
    List<ToDo> results = [];
    results = todosList
        .where((element) =>
            element.taskName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      searchList = results;
    });
  }

  void addTask(String toDo) {
    final newTask = ToDo(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      taskName: toDo,
    );

    setState(() {
      todosList.add(newTask);
    });

    db.addTaskDb(newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBgColor,
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: tBlue,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'ToDo App',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.edit, color: Colors.white, size: 30,)
                      ],
                    ),
                  ),
                  ListTile(
                    leading: IconButton(
                      icon: const Icon(Icons.nights_stay,
                          color: tBlack, size: 30),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text(
                'Made By Rohan Mitra🗿',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 18,
                ),
                decoration: const BoxDecoration(
                  color: tBgColor,
                ),
                child: Column(children: [
                  searchBox(),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                      bottom: 25,
                    ),
                    child: const Text(
                      "All Tasks",
                      style: TextStyle(
                          color: tBlack,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ]),
              ),
              Expanded(
                  child: ListView(children: [
                for (ToDo todoo in searchList.reversed)
                  ToDoTile(
                    todo: todoo,
                    onChanged: checkBoxChanged,
                    onDelete: deleteTask,
                  ),
              ])),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
          if (result != null) {
            addTask(result);
          }
        },
        backgroundColor: tBlue,
        elevation: 5.0,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        onChanged: (value) => {searchTask(value)},
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tBlack,
            size: 25,
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 25, maxHeight: 20),
          hintText: " Search",
          hintStyle: TextStyle(color: tGrey, fontSize: 20),
          border: InputBorder.none,
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AppBar _buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: tBgColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /*IconButton(icon: Icon(Icons.menu, color: tBlack, size:30,),
                onPressed: (){
                  _scaffoldKey.currentState?.openDrawer();
                },
          ),*/
            const Text(
              "ToDo Lists",
              style: TextStyle(color: tBlack, fontWeight: FontWeight.bold),
            ),
            Container(
                height: 40,
                width: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.asset(
                    "assets/ToDo_icon.png",
                    fit: BoxFit.cover,
                  ),
                ))
          ],
        ));
  }

  @override
  void dispose() {
    Hive.box('todoBox').close();
    super.dispose();
  }
}
