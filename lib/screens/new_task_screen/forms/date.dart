import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:to_do_app_hive/contollers/form_controllers.dart';

class TaskDateForm extends StatelessWidget {
  const TaskDateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      confirmText: "CONFIRM",
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      cancelText: 'CANCEL',
      controller: taskDeadlineController,
      name: 'taskDeadline',
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: DateTime.now(),
      initialValue: DateTime.now(),
      inputType: InputType.date,
      decoration: const InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.date_range,
          color: Colors.orange,
        ),
        label: Text("Task Deadline"),

        // helperText: "Deadline required",
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
