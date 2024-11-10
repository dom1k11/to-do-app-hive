import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_hive/contollers/form_controllers.dart';
import 'package:to_do_app_hive/task_service.dart';

class newTaskScreen extends StatefulWidget {
  const newTaskScreen({super.key});

  @override
  State<newTaskScreen> createState() => _newTaskScreenState();
}



class _newTaskScreenState extends State<newTaskScreen> {
  @override
  void initState() {
    super.initState();
    // taskNameController = TextEditingController(text: "New");
    // taskDescriptionController = TextEditingController(text: "Task");
    // taskPriorityController.text = 'Medium'; // Значение по умолчанию

  }

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
            initialDate: DateTime.now(),
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
            // initialValue: "Medium",
            onChanged: (value) {
              taskPriorityController.text = value.toString();
              print("Selected priority: $taskPriorityController");
            },
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
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
