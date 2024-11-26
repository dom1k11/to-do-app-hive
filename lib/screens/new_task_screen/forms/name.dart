import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:to_do_app_hive/contollers/form_controllers.dart';

class TaskNameForm extends StatelessWidget {
  const TaskNameForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: taskNameController,
      name: 'Task Name',
      decoration: const InputDecoration(
          border: InputBorder.none,
          // helperText: "Task name required",
          label: Text("Task Name"),
          prefixIcon: Icon(Icons.edit_note_outlined)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a task name";
        }
        return null;
      },
    );
  }
}
