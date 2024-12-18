import "package:flutter/material.dart";
import "package:todoapp/utils/my_button.dart";

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[100],
      content: Container(
        height: 120,
        width: 300,
        color: Colors.yellow[100],
        child: Column(
          children: <Widget>[
            // Get user input
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.yellow,
                  ),
                ),
                hintText: "Add your new task here",
              ),
            ),

            // Buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Save button
                MyButton(
                  label: "Save",
                  onPressed: onSave,
                ),

                // To space it
                const SizedBox(
                  width: 10,
                ),

                // Cancel button
                MyButton(
                  label: "Cancel",
                  onPressed: onCancel,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
