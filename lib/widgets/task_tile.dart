// task_tile.dart
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/task_service.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final int index;

  const TaskTile({
    Key? key,
    required this.task,
    required this.index,
  }) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              onPressed: (context) {
                setState(() {
                  _visible = !_visible;
                });
                Future.delayed(const Duration(milliseconds: 500), () {
                  setCompleted(widget.index);
                });
              },
              backgroundColor: const Color(0xFF32EE25),
              foregroundColor: Colors.white,
              icon: Icons.done,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              onPressed: (context) {
                setState(() {
                  _visible = !_visible;
                });
                Future.delayed(const Duration(milliseconds: 500), () {
                  deleteTask(widget.index);
                });
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: ListTile(
          leading: const Icon(
            Icons.arrow_right,
            color: Colors.green,
          ),
          title: Text(
            widget.task.taskName,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.task.taskPriority),
              Text(widget.task.taskDescription),
              Text(DateFormat("MM/dd/yyyy").format(widget.task.taskDeadline)),
            ],
          ),
          trailing: const Icon(
            Icons.arrow_left,
            color: Colors.red,
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/edit_screen',
              arguments: {
                'task': widget.task,
                'index': widget.index
              }, // Передаем задачу и индекс
            );
          },
        ),
      ),
    );
  }
}
