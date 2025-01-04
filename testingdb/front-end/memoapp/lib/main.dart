import 'package:flutter/material.dart';
import 'package:memoapp/pages/home_page.dart';
import './utils/theme.dart';
import 'package:get/get.dart';
import 'utils/dependencies.dart' as dependencies;
import 'utils/routes.dart' as routes;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Memo App',
      theme: customTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: dependencies.InitialBinding(),
      getPages: routes.getPages,
      home: const HomePage(),
    );
  }
}
