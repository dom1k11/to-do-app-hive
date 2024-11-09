import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/task_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Открываем коробку один раз при загрузке
    Hive.openBox<Task>('tasksBox');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task List"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Task>('tasksBox').listenable(),
            builder: (context, Box<Task> box, _) {
              final tasks = box.values.toList();

              if (tasks.isEmpty) {
                return const Center(child: Text('No tasks available.'));
              }

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  return ListTile(
                    // leading: FormBuilderCheckbox(name: '', title: SizedBox(),),
                    title: Text(task.taskName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.taskPriority),
                        Text(task.taskDescription),
                        Text(
                            DateFormat('yyyy-MM-dd').format(task.taskDeadline)),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        // Отображение срока выполнения задачи

                        IconButton(
                          onPressed: () {
                            deleteTask(index); // Удаление задачи
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/edit_screen');
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/tasks_screen');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
