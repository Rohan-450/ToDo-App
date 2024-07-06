import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:provider/provider.dart';
//import 'package:todo_app/constants/theme_provider.dart';
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
  //List<ToDo> searchList = [];
  String searchQuery = "";
  List<ToDo> get searchList {
    if (searchQuery.isEmpty) {
      return todosList;
    }
    return todosList
        .where((element) =>
            element.taskName!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  HiveDB db = HiveDB();

  @override
  void initState() {
    todosList = db.getTodos();
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

  /*void searchTask(String query) {
    List<ToDo> results = [];
    results = todosList
        .where((element) =>
            element.taskName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      searchList = results;
    });
  }*/

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
      //drawer: _drawerMode(context),
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
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "All Tasks",
                          style: TextStyle(
                              color: tBlack,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ],
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
          Icons.edit,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Drawer _drawerMode(BuildContext context) {
    return Drawer(
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
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ),
                ),
                /*ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.nights_stay,
                        color: tBlack, size: 30),
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                      Navigator.pop(context);
                    },
                  ),
                ),*/
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.info, color: tBlack, size: 30),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('App Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('App Name: ToDo App', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Text('Version: 1.1.0', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Text('Author: Rohan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Close', style: TextStyle(fontSize: 18 ,color: Colors.black) ,),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Made By Rohan🗿',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
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
        cursorColor: tBlack,
        onChanged: (value) => setState(() => searchQuery = value),
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
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
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
            const Icon( Icons.menu, color: tBlack, size:30,),
            const Text(
              "ToDo Lists",
              style: TextStyle(color: tBlack, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: 40,
                width: 40,
                child: GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      "assets/ToDo_icon.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('App Information',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          content: const SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('App Name: ToDo App',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text('Version: 1.1.0',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text('Author: Rohan',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Close',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  )),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  
                  },
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
