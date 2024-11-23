import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/widgets/animated_fab.dart';
import 'package:to_do_app_hive/widgets/task_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
     {

  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();


    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override


  @override
  Widget build(BuildContext context) {
    // Открываем коробку один раз при загрузке
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
          padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: AnimatedOpacity(
                        opacity: _opacity,
                        duration: const Duration(milliseconds: 1000),
                        child: const Text(
                          "You don't have any tasks, want to add a new one?",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // Сброс текста, если появились задачи
                if (_opacity != 0.0) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      _opacity = 0.0;
                    });
                  });
                }

                return AnimationLimiter(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final oneTask = tasks[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        delay: const Duration(milliseconds: 200), // Добавление задержки в 500 мс
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
            },
          ),
        ),
      ),
      floatingActionButton: const AnimatedFab(),
    );
  }
}
