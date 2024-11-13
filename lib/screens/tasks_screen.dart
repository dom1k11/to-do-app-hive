import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/widgets/custom_fab.dart';
import 'package:to_do_app_hive/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _expansionController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _expansionAnimation;
  bool _isExpanded = false; // Флаг для отслеживания состояния кнопки

  @override
  void initState() {
    super.initState();

    // Контроллер для анимации вращения
    _rotationController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.1415927 * 2).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linearToEaseOut),
    );

    // Контроллер для анимации расширения кнопки
    _expansionController = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _expansionAnimation = Tween<double>(begin: 56.0, end: 200.0).animate(
      CurvedAnimation(parent: _expansionController, curve: Curves.bounceOut),
    );

    // Запускаем анимацию вращения
    _rotationController.forward().then((_) {
      // После завершения вращения запускаем анимацию расширения кнопки
      Future.delayed(Duration(milliseconds: 250), () {
        setState(() {
          _isExpanded = true;
          _expansionController.forward(); // Запускаем расширение кнопки
        });
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
            icon: const Icon(Icons.done_all)),
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
      floatingActionButton: AnimatedBuilder(
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
    );
  }
}
