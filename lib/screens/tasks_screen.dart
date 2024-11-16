import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/widgets/task_tile.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _expansionController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _expansionAnimation;
  bool _isVisible = false; // Флаг для управления видимостью кнопки
  bool _isExpanded = false; // Флаг для отслеживания состояния кнопки

  @override
  void initState() {
    super.initState();

    // Контроллер для анимации вращения
    _rotationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.1415927 * 3).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.ease),
    );

    // Контроллер для анимации расширения кнопки
    _expansionController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _expansionAnimation = Tween<double>(begin: 56.0, end: 200.0).animate(
      CurvedAnimation(parent: _expansionController, curve: Curves.easeOut),
    );

    // Задержка перед началом появления кнопки
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true; // Показываем кнопку через AnimatedOpacity
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
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/done_tasks_screen');
          },
          icon: const Icon(Icons.done_all),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Task>('tasksBox').listenable(),
            builder: (context, Box<Task> box, _) {
              final tasks = box.values.toList();

              if (tasks.isEmpty) {
                return const Center(child: Text('No tasks available.'));
              }

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final oneTask = tasks[index];
                  return TaskTile(
                    task: oneTask,
                    index: index,
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isVisible ? 1 : 0, // Плавное появление кнопки
        duration: Duration(milliseconds: 500),
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
          animation: Listenable.merge([_rotationController, _expansionController]),
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
              angle: _rotationAnimation.value, // Применяем вращение
              child: Container(
                width: _expansionAnimation.value, // Плавное расширение
                child: FloatingActionButton.extended(
                  label: _isExpanded
                      ? FadeTransition(
                    opacity: _expansionController,
                    child: const Text("Create Task"),
                  )
                      : SizedBox.shrink(), // Показываем текст только если кнопка расширена
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
