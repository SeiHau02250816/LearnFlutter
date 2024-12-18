import "package:flutter/material.dart";

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // Variables
  int _cnt = 0;

  // Methods
  void _increment() {
    // setState helps to rebuild the widget, thus refreshing the UI
    setState(() {
      _cnt++;
    });
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Counter Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Message
            Text("You pushed button this many times:"),

            // Show the actual counter value
            Text(
              '$_cnt',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),

            // Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(60, 60), // width: 150, height: 50
                backgroundColor: Color.fromARGB(255, 213, 189, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                // Optional: Shadow color
                shadowColor: Colors.tealAccent,
              ),
              onPressed: _increment,
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
