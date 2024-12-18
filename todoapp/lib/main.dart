import 'package:flutter/material.dart';
import 'package:todoapp/pages/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Init hive
  await Hive.initFlutter();

  // open a box
  // ignore: unused_local_variable
  var box = await Hive.openBox('todo_list');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App Demo',
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.yellow,
        primarySwatch: Colors.yellow,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.yellow,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
