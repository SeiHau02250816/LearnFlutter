import "package:flutter/material.dart";
import "package:todoapp/data/database.dart";
import "package:todoapp/utils/dialog_box.dart";
import "package:todoapp/utils/todo_tile.dart";
import "package:hive_flutter/hive_flutter.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Reference the hive box
  final _myBox = Hive.box('todo_list');
  TodoDatabase db = TodoDatabase();

  // Text Controller
  final _controller = TextEditingController();

  // Methods
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });

    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });

    Navigator.of(context).pop();

    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });

    db.updateDatabase();
  }

  @override
  void initState() {
    // If this is the first time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    }
    // There already exists data
    else {
      db.loadData();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 224, 153),
      appBar: AppBar(
        title: const Text("To Do"),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
