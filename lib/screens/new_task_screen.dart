import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_hive/task_service.dart';

class newTaskScreen extends StatefulWidget {
  const newTaskScreen({super.key});

  @override
  State<newTaskScreen> createState() => _newTaskScreenState();
}

TextEditingController taskNameController = TextEditingController(text: "task name");
TextEditingController taskDescriptionController = TextEditingController(text: "task descr");
TextEditingController taskDeadlineController = TextEditingController();
TextEditingController taskPriorityController = TextEditingController();

class _newTaskScreenState extends State<newTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            inputType: InputType.date,
            decoration: InputDecoration(
              label: Text("Task Deadline"),
            ),
          ),
          FormBuilderChoiceChip(
            name: 'priority',
            decoration: InputDecoration(labelText: 'Priority'),
            options: [
              FormBuilderChipOption(value: 'Low', child: Text('Low')),
              FormBuilderChipOption(value: 'Medium', child: Text('Medium')),
              FormBuilderChipOption(value: 'High', child: Text('High')),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final dateFormat = DateFormat("MM/dd/yyyy"); // Указываем формат
          final taskDeadline = dateFormat.parse(taskDeadlineController.text);
          // Передаем данные из контроллеров в функцию addTask
          addTask(
            taskNameController.text,
            taskDescriptionController.text,
            taskDeadline, // Преобразуем строку в DateTime
            taskPriorityController.text,
          );
          Navigator.pop(context);

          taskNameController.clear();
          taskDescriptionController.clear();
          taskDeadlineController;
        },
        child: Icon(Icons.add),

      ),
    );
  }
}
