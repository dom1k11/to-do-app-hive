import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/utils/empty_tasks_message.dart';
import 'package:to_do_app_hive/utils/task_listview.dart';
import 'package:to_do_app_hive/widgets/animated_fab.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Hive.openBox<Task>('tasksBox');
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Hive.openBox<Task>('tasksBox');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task List"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/done_tasks_screen');
          },
          icon: const Icon(Icons.done_all),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Task>('tasksBox').listenable(),
            builder: (context, Box<Task> box, _) {
              final tasks = box.values.toList();

              if (tasks.isEmpty) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (_opacity == 0.0) {
                    setState(() {
                      _opacity = 1.0;
                    });
                  }
                });
                return EmptyTasksMessage(opacity: _opacity);
              } else {
                // Сброс текста, если появились задачи
                if (_opacity != 0.0) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      _opacity = 0.0;
                    });
                  });
                }
                return Container(
                  margin: EdgeInsets.symmetric(),
                    child: TaskListView(tasks: tasks));
              }
            },
          ),
        ),
      ),
      floatingActionButton: const AnimatedFab(),
    );
  }
}
