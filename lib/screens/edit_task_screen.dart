import 'package:flutter/material.dart';

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
    taskNameController.text = widget.task.taskName;
    taskDescriptionController.text = widget.task.taskDescription;
    taskPriorityController.text = widget.task.taskPriority;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Screen"),
      ),
      body: Column(
        children: [
          Divider(
            color: Colors.grey.shade800,
          ),
          const TaskNameForm(),
          Divider(
            color: Colors.grey.shade800,
          ),
          const TaskDescriptionForm(),
          Divider(
            color: Colors.grey.shade800,
          ),
          // Передача начальной даты в TaskDateForm
          TaskDateForm(initialDate: widget.task.taskDeadline),
          Divider(
            color: Colors.grey.shade800,
          ),
          const PriorityForm(),
          Divider(
            color: Colors.grey.shade800,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Вставить логику сохранения или редактирования задачи
          Navigator.pop(context);
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
