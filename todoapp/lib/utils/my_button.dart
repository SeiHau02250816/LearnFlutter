import "package:flutter/material.dart";

class MyButton extends StatelessWidget {
  final String label;
  VoidCallback onPressed;

  // Constructor
  MyButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(label),
    );
  }
}
