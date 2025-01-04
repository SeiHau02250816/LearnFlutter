import "package:flutter/material.dart";
import "package:get/get.dart";
import "../utils/dependencies.dart" as dependencies;

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Sign out?",
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
          child: const Text("Yes"),
          onPressed: () {
            Get.find<dependencies.AuthController>().signOut();
          },
        ),
        ElevatedButton(
          child: const Text("No"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
