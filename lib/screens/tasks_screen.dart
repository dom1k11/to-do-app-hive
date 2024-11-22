import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/widgets/task_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _expansionController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _expansionAnimation;
  bool _isVisible = false; // Флаг для управления видимостью кнопки
  bool _isExpanded = false; // Флаг для отслеживания состояния кнопки
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Контроллер для анимации вращения
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * 3.1415927 * 3).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.ease),
    );

    // Контроллер для анимации расширения кнопки
    _expansionController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _expansionAnimation = Tween<double>(begin: 56.0, end: 200.0).animate(
      CurvedAnimation(parent: _expansionController, curve: Curves.easeOut),
    );

    // Задержка перед началом появления кнопки
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true; // Показываем кнопку через AnimatedOpacity
      });
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _expansionController.dispose();
    super.dispose();
  }

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
                        duration: Duration(milliseconds: 375),
                        delay: Duration(milliseconds: 200), // Добавление задержки в 500 мс
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

                // return AnimatedList(
                //   itemBuilder: (BuildContext context, int index,
                //       Animation<double> animation) {
                //     final oneTask = tasks[index];
                //     return Column(
                //       children: [
                //         TaskTile(task: oneTask, index: index),
                //         const SizedBox(
                //           height: 1,
                //         ),
                //       ],
                //     );
                //   },
                // );
              }
            },
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isVisible ? 1 : 0, // Плавное появление кнопки
        duration: const Duration(milliseconds: 500),
        onEnd: () {
          // После появления кнопки запускаем остальные анимации
          _rotationController.forward().then((_) {
            setState(() {
              _isExpanded = true; // Обновляем состояние для расширения кнопки
              _expansionController.forward();
            });
          });
        },
        child: AnimatedBuilder(
          animation:
              Listenable.merge([_rotationController, _expansionController]), //доделать
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
              angle: _rotationAnimation.value, // Применяем вращение
              child: SizedBox(
                width: _expansionAnimation.value, // Плавное расширение
                child: FloatingActionButton.extended(
                  label: _isExpanded
                      ? FadeTransition(
                          opacity: _expansionController,
                          child: const Text("Create Task"),
                        )
                      : const SizedBox.shrink(),
                  // Показываем текст только если кнопка расширена
                  icon: const Icon(Icons.edit_note_outlined),
                  backgroundColor: Colors.greenAccent,
                  onPressed: () {
                    Navigator.pushNamed(context, '/new_task_screen');
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
