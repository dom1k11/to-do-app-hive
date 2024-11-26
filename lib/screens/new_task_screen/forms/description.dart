import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../contollers/form_controllers.dart';

class TaskDescriptionForm extends StatelessWidget {
  const TaskDescriptionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: taskDescriptionController,
      name: 'Task Description',
      decoration: const InputDecoration(
          border: InputBorder.none,
          label: Text("Task Description"),
          prefixIcon: Icon(Icons.description_outlined)),
    );
  }
}
