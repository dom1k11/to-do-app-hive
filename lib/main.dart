import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/screens/done_tasks_screen.dart';
import 'package:to_do_app_hive/screens/edit_task_screen.dart';
import 'package:to_do_app_hive/screens/new_task_screen.dart';
import 'package:to_do_app_hive/screens/welcome_screen.dart';
import '../screens/tasks_screen.dart';

void main() async {
  try {
    await Hive.initFlutter();
    print("Hive initialized");
  } catch (e) {
    print('Error initializing Hive: $e');
  }
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasksBox');
  await Hive.openBox<Task>('completedTasksBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.orange,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 255, 231, 76),
        ),
        textTheme: const TextTheme(
          // bodyLarge: TextStyle(color: Colors.orange), // Для крупного текста


        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 53, 53, 53),
      ),

      // home: const HomePage(),
      // home: newTaskScreen(),
      routes: {
        '/': (context) => const TasksScreen(), // change to WelcomeScreen(),
        // '/new_task_screen': (context) => const NewTaskScreen(),
        '/edit_screen': (context) {
          final task = ModalRoute.of(context)?.settings.arguments as Task;
          return EditTaskScreen(task: task);
        },
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/tasks_screen':
            return PageTransition(
              child: const TasksScreen(),
              type: PageTransitionType.rightToLeftWithFade,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 500),
              reverseDuration: const Duration(milliseconds: 500),
              opaque: true,
            );
          case '/done_tasks_screen': // Добавляем обработку перехода на DoneTasksScreen
            return PageTransition(
              child: const DoneTasksScreen(),
              type: PageTransitionType.leftToRightWithFade,
              // Анимация справа налево
              curve: Curves.easeInOut,
              // Плавное изменение
              duration: const Duration(milliseconds: 500),
              // Длительность
              reverseDuration: const Duration(milliseconds: 500),
              // Длительность обратной анимации
              opaque: true,
            );
          case '/new_task_screen': // Добавляем обработку перехода на DoneTasksScreen
            return PageTransition(
              child: const NewTaskScreen(),
              type: PageTransitionType.rightToLeftWithFade,
              // Анимация справа налево
              curve: Curves.easeInOut,
              // Плавное изменение
              duration: const Duration(milliseconds: 500),
              // Длительность
              reverseDuration: const Duration(milliseconds: 500),
              // Длительность обратной анимации
              opaque: true,
            );
          default:
            return null;
        }
      },
    );
  }
}
