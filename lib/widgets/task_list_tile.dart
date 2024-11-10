// task_tile.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/task_service.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final int index;

  const TaskTile({
    Key? key,
    required this.task,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.taskName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.taskPriority),
          Text(task.taskDescription),
          Text(DateFormat("MM/dd/yyyy").format(task.taskDeadline)),
        ],
      ),
      trailing: Column(
        children: [
          IconButton(
            onPressed: () {
              deleteTask(index); // Удаление задачи
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/edit_screen',
          arguments: task, // Передаем объект задачи
        );
      },
    );
  }
}
