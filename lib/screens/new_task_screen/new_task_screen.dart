import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:to_do_app_hive/contollers/form_controllers.dart';
import 'package:to_do_app_hive/screens/new_task_screen/forms/priority_form.dart';
import 'package:to_do_app_hive/screens/new_task_screen/forms/date.dart';
import 'package:to_do_app_hive/screens/new_task_screen/forms/description.dart';
import 'package:to_do_app_hive/screens/new_task_screen/forms/name.dart';
import 'package:to_do_app_hive/hive/task_service.dart';
import 'package:to_do_app_hive/widgets/snackbar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    clearControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Task"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
              const TaskDateForm(),
              Divider(
                color: Colors.grey.shade800,
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const PriorityForm(),
              ),
              Divider(
                color: Colors.grey.shade800,
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
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                taskSnackBar(context, "New Task added!", Colors.cyanAccent);
              }
            });
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
