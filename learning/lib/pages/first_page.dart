import 'package:flutter/material.dart';
import 'package:learning/pages/home.dart';
import 'package:learning/pages/profile.dart';
import 'package:learning/pages/settings.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final List _pages = [
    // Home page
    const HomePage(),

    // Setting page
    const SettingsPage(),

    // Profile page
    const ProfilePage(),
  ];

  int selectedIndex = 0;

  void NavigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
      ),
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: NavigateBottomBar,
        items: const <BottomNavigationBarItem>[
          // Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          // Profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),

          // Setting
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
