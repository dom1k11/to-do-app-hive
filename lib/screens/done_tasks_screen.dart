import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/theme/text_style/app_bar.dart';

class DoneTasksScreen extends StatefulWidget {
  const DoneTasksScreen({super.key});

  @override
  State<DoneTasksScreen> createState() => _DoneTasksScreenState();
}

class _DoneTasksScreenState extends State<DoneTasksScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    super.initState();
  }

  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Done Tasks", style: appbarTextStyle,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Task>('completedTasksBox').listenable(),
          builder: (context, Box<Task> box, _) {
            final completedTasks = box.values.toList();

            if (completedTasks.isEmpty) {
              return Center(
                  child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "You don't have any completed tasks.",
                        style: TextStyle(fontSize: 24),
                      )));
            }

            return ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  color: Colors.grey.shade800,
                  child: ListTile(
                    title: Text(task.taskName, maxLines: 3,),
                    subtitle: Text(task.taskDescription, maxLines: 3,),
                    trailing: const Icon(Icons.check, color: Colors.green),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
