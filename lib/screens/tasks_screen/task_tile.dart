// task_tile.dart
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/hive/task_service.dart';
import 'package:to_do_app_hive/utils/deadline.dart';
import 'package:to_do_app_hive/widgets/snackbar.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final int index;

  const TaskTile({
    super.key,
    required this.task,
    required this.index,
  });

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
      child: Container(
        color: widget.task.taskPriority == 'High'
            ? const Color.fromARGB(50, 215, 93, 93)
            : widget.task.taskPriority == 'Medium'
                ? const Color.fromARGB(50, 255, 212, 0)
                : const Color.fromARGB(50, 127, 238, 175),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            // dismissible: DismissiblePane(onDismissed: () {}),
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                onPressed: (context) {
                  setState(() {
                    _visible = !_visible;
                    taskSnackBar(
                        context, "Task Completed!", Colors.greenAccent);
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
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                onPressed: (context) {
                  setState(() {
                    _visible = !_visible;
                    taskSnackBar(
                        context, "Task succesfully deleted!", Colors.redAccent);
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
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ListTile(
              leading: const Icon(
                Icons.arrow_right,
                color: Colors.green,
              ),
              title: Text(
                widget.task.taskName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(widget.task.taskPriority),
                  Text(
                    widget.task.taskDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.orange),
                  ),
                  Row(
                    children: [
                      Text(DateFormat("MM/dd/yyyy")
                          .format(widget.task.taskDeadline)),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        widget.task.deadlineCounter,
                        style: TextStyle(
                            color: widget.task.deadlineCounterColor),
                      ),
                    ],
                  ),
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
                  arguments: widget.task, // Передаётся сразу Task
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
