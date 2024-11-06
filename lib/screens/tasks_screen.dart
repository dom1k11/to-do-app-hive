import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_hive/models/task_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task List"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: Hive.openBox<Task>('tasksBox'), // Ожидаем, пока откроется коробка
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Если коробка ещё не открыта
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final box = Hive.box<Task>('tasksBox');
              final tasks = box.values.toList(); // Получаем все задачи из коробки

              if (tasks.isEmpty) {
                return const Center(child: Text('No tasks available.'));
              }

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  return ListTile(
                    title: Text(task.taskName),
                    subtitle: Text(task.taskDescription),
                    trailing: Text(DateFormat('yyyy-MM-dd').format(task.taskDeadline)),
                    // onTap: () {
                    //   // Здесь можно добавить логику для открытия подробностей задачи
                    // },
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
