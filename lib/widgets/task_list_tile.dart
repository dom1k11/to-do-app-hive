// task_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        // dismissible: DismissiblePane(onDismissed: () {}),
        children:  [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {setCompleted(index);},
            backgroundColor: Color(0xFF32EE25),
            foregroundColor: Colors.white,
            icon: Icons.done,
            label: 'Complete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children:  [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) { deleteTask(index);},
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
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
      ),
    );
  }
}
