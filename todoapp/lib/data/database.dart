import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todoList = [];

  // Reference the box
  final _myBox = Hive.box('todo_list');

  // Methods
  /* Create initial data - Run this method if this is the first time opening the app */
  void createInitialData() {
    todoList = [
      ['Make Tutorial', false],
      ['Do Exercise', false],
    ];
  }

  /* Load the data from database */
  void loadData() {
    todoList = _myBox.get('TODOLIST');
  }

  /* Update the database - Anytime a user changes something */
  void updateDatabase() {
    _myBox.put('TODOLIST', todoList);
  }
}
