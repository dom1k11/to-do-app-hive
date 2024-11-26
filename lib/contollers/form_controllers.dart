import 'package:flutter/material.dart';

TextEditingController taskNameController = TextEditingController();
TextEditingController taskDescriptionController = TextEditingController();
TextEditingController taskDeadlineController = TextEditingController();
TextEditingController taskPriorityController = TextEditingController();


Future<void> clearControllers() async {
  taskNameController.clear();
  taskDescriptionController.clear();
  taskDeadlineController.clear();
  taskPriorityController.clear();
}