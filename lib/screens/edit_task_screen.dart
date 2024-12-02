import 'package:flutter/material.dart';import 'package:intl/intl.dart';
import 'package:to_do_app_hive/contollers/form_controllers.dart';
import 'package:to_do_app_hive/screens/new_task_screen/forms/date.dart';
import 'package:to_do_app_hive/screens/new_task_screen/forms/description.dart';
import 'package:to_do_app_hive/screens/new_task_screen/forms/name.dart';
import 'package:to_do_app_hive/screens/new_task_screen/forms/priority_form.dart';
import '../models/task_model.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.task});

  final Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  void initState() {
    super.initState();
    taskNameController = TextEditingController(text: widget.task.taskName);
    taskDescriptionController =
        TextEditingController(text: widget.task.taskDescription);
    taskDeadlineController = TextEditingController(
        text: DateFormat("MM/dd/yyyy").format(widget.task.taskDeadline));
    taskPriorityController =
        TextEditingController(text: widget.task.taskPriority);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Divider(
            color: Colors.grey.shade800,
          ),
          TaskNameForm(),
          Divider(
            color: Colors.grey.shade800,
          ),
          TaskDescriptionForm(),
          Divider(
            color: Colors.grey.shade800,
          ),
          TaskDateForm(),
          Divider(
            color: Colors.grey.shade800,
          ),
          PriorityForm(),
          Divider(
            color: Colors.grey.shade800,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // editTask(index); // Вызов метода редактирования с передачей индекса

          Navigator.pop(context);
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
