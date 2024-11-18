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

  // @override
  // void initState() {
  //   taskDescriptionController.text = "No Description";
  //   taskNameController.text = "New Task Name";
  //   taskDeadlineController.text =
  //       DateFormat("MM/dd/yyyy").format(DateTime.now());
  // }

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
              ),
              Divider(
                color: Colors.grey,
              ),
              FormBuilderTextField(
                controller: taskDescriptionController,
                name: 'Task Description',
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    label: Text("Task Description"),
                    prefixIcon: Icon(Icons.description_outlined)),
              ),
              Divider(
                color: Colors.grey,
              ),
              FormBuilderDateTimePicker(
                controller: taskDeadlineController,
                name: 'taskDeadline',
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialDate: DateTime.now(),
                inputType: InputType.date,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.date_range),
                  label: Text("Task Deadline"),

                  // helperText: "Deadline required",
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please select a deadline";
                  }
                  return null;
                },
              ),
              Divider(color: Colors.grey),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FormBuilderChoiceChip(
                  spacing: 8,
                  showCheckmark: false,
                  alignment: WrapAlignment.center,
                  selectedColor: Colors.greenAccent,
                  backgroundColor: Color.fromARGB(255, 220, 220, 220),
                  name: 'priority',
                  labelPadding: EdgeInsets.symmetric(horizontal: 50),
                  padding: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  decoration: InputDecoration(
                    // labelText: 'Priority',
                    // helperText: "Priority required",
                    border: InputBorder.none,
                  ),
                  options: const [
                    FormBuilderChipOption(value: 'Low', child: Text('Low')),
                    FormBuilderChipOption(
                        value: 'Medium', child: Text('Medium')),
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
