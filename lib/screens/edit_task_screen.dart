import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_hive/contollers/form_controllers.dart';

import '../task_service.dart';
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
     taskDescriptionController = TextEditingController(text: widget.task.taskDescription);
     taskDeadlineController = TextEditingController(text: DateFormat("MM/dd/yyyy").format(widget.task.taskDeadline));
     taskPriorityController = TextEditingController(text: widget.task.taskPriority);
  }

  @override
  // void dispose() {
  //   taskNameController.dispose();
  //   taskDescriptionController.dispose();
  //   taskDeadlineController.dispose();
  //   taskPriorityController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Screen"),
      ),
      body: Column(
        children: [
          FormBuilderTextField(
            controller: taskNameController,
            name: 'Task Name',
            decoration: InputDecoration(
              label: Text("Task Name"),
            ),
          ),
          FormBuilderTextField(
            controller: taskDescriptionController,
            name: 'Task Description',
            decoration: InputDecoration(
              label: Text("Task Description"),
            ),
          ),
          FormBuilderDateTimePicker(
            controller: taskDeadlineController,
            name: 'taskDeadline',
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365)),
            initialDate: DateTime.now(),
            inputType: InputType.date,
            decoration: InputDecoration(
              label: Text("Task Deadline"),
            ),
            initialValue: widget.task.taskDeadline,
          ),
          FormBuilderChoiceChip(
            name: 'priority',
            decoration: InputDecoration(labelText: 'Priority'),
            options: [
              FormBuilderChipOption(value: 'Low', child: Text('Low')),
              FormBuilderChipOption(value: 'Medium', child: Text('Medium')),
              FormBuilderChipOption(value: 'High', child: Text('High')),
            ],
            onChanged: (value) {
              taskPriorityController.text = value.toString();
              print("Selected priority: $taskPriorityController");
            },
            initialValue: widget.task.taskPriority,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

           // editTask(index); // Вызов метода редактирования с передачей индекса

          Navigator.pop(context);
        },

        child: Icon(Icons.edit),
      ),
    );
  }
}
