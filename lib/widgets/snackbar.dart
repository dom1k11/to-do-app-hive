import 'package:flutter/material.dart';

void TaskSnackBar(BuildContext context, String message, Color color)
{
  final taskSnackBar = SnackBar(
    content: Text(message,  style: TextStyle(color: Colors.black),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(taskSnackBar);
}