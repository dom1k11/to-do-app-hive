import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app_hive/models/task_model.dart';

class DoneTasksScreen extends StatefulWidget {
  const DoneTasksScreen({super.key});

  @override
  State<DoneTasksScreen> createState() => _DoneTasksScreenState();
}

class _DoneTasksScreenState extends State<DoneTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Done Tasks"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Task>('completedTasksBox').listenable(),
          builder: (context, Box<Task> box, _) {
            final completedTasks = box.values.toList();

            if (completedTasks.isEmpty) {
              return const Center(child: Text('No completed tasks.'));
            }

            return ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return ListTile(
                  title: Text(task.taskName),
                  subtitle: Text(task.taskDescription),
                  trailing: Icon(Icons.check, color: Colors.green),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
