import 'package:flutter/material.dart';

void taskSnackBar(BuildContext context, String message, Color color)
{
  final taskSnackBar = SnackBar(
    content: Text(message,  style: const TextStyle(color: Colors.black),
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(taskSnackBar);
}