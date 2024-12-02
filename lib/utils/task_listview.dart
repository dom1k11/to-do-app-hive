import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/screens/tasks_screen/task_tile.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final reversedTasks = List<Task>.from(tasks.reversed);
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final oneTask = reversedTasks[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            delay: const Duration(milliseconds: 200),
            // Добавление задержки в 500 мс
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: TaskTile(task: oneTask, index: index),
              ),
            ),
          );
        },
      ),
    );
  }
}
