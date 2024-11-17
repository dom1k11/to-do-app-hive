import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_hive/contollers/form_controllers.dart';
import 'package:to_do_app_hive/task_service.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();

}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {

    taskDescriptionController.text = "No Description";
    taskNameController.text = "New Task Name";
    taskDeadlineController.text = DateFormat("MM/dd/yyyy").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Task")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                controller: taskNameController,
                name: 'Task Name',
                decoration: const InputDecoration(
                  helperText: "Task name required",
                  label: Text("Task Name"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a task name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                controller: taskDescriptionController,
                name: 'Task Description',
                decoration: const InputDecoration(
                  label: Text("Task Description"),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderDateTimePicker(
                controller: taskDeadlineController,
                name: 'taskDeadline',
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialDate: DateTime.now(),
                inputType: InputType.date,
                decoration: const InputDecoration(
                  label: Text("Task Deadline"),
                  helperText: "Deadline required",
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please select a deadline";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FormBuilderChoiceChip(
                name: 'priority',
                decoration: const InputDecoration(labelText: 'Priority', helperText: "Priority required",),
                options: const [
                  FormBuilderChipOption(value: 'Low', child: Text('Low')),
                  FormBuilderChipOption(value: 'Medium', child: Text('Medium')),
                  FormBuilderChipOption(value: 'High', child: Text('High')),
                ],
                onChanged: (value) {
                  taskPriorityController.text = value.toString();
                },
                validator: (value) {
                  if (value == null) {
                    return "Please select a priority";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // Если форма валидна, выполняем действие
            final dateFormat = DateFormat("MM/dd/yyyy");
            final taskDeadline = dateFormat.parse(taskDeadlineController.text);

            addTask(
              taskNameController.text,
              taskDescriptionController.text,
              taskDeadline,
              taskPriorityController.text,
            );

            Navigator.pop(context);
          } else {
            // Если форма невалидна
            print("Form is not valid. Please fill in all fields.");
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
