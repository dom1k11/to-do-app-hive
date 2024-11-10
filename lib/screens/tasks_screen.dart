import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/widgets/task_list_tile.dart';

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
                  final oneTask = tasks[index];
                  return TaskTile(
                    task: oneTask,
                    index: index,
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
