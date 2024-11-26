import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TaskDateForm extends StatelessWidget {
  const TaskDateForm({super.key, required this.initialDate});

  final DateTime? initialDate; // Принимает начальное значение

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: 'taskDeadline',
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialValue: initialDate, // Используем initialValue
      inputType: InputType.date,
      decoration: const InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(Icons.date_range),
        label: Text("Task Deadline"),
      ),
      validator: (value) {
        if (value == null) {
          return "Please select a deadline";
        }
        return null;
      },
    );
  }
}
