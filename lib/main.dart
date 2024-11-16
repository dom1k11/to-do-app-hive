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
        // Основной цвет приложения
        hintColor: Colors.orange,
        // Акцентный цвет (например, для FloatingActionButton)
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 135, 137, 192), // Цвет AppBar
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor:
              Color.fromARGB(255, 255, 231, 76), // Цвет FloatingActionButton
        ),
        textTheme: const TextTheme(
          // bodyLarge: TextStyle(color: Color.fromARGB(255, 135, 137, 192)), // Цвет для bodyLarge текста
          bodyMedium: TextStyle(
              color: Color.fromARGB(
                  255, 135, 137, 192)), // Цвет для bodyMedium текста
          // bodySmall: TextStyle(color: Color.fromARGB(255, 135, 137, 192)), // Цвет для bodySmall текста
        ),
        scaffoldBackgroundColor: Colors.white70,
      ),
      // home: const HomePage(),
      // home: newTaskScreen(),
      routes: {
        '/': (context) => const WelcomeScreen(),
        // '/tasks_screen': (context) => TasksScreen(),
        '/new_task_screen': (context) => const NewTaskScreen(),
        '/edit_screen': (context) {
          final task = ModalRoute.of(context)?.settings.arguments
              as Task; // Получаем объект Task
          return EditTaskScreen(task: task); // Передаем его в EditTaskScreen
        },
        '/done_tasks_screen': (context) => const DoneTasksScreen()
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/tasks_screen':
            return PageTransition(
              child: TasksScreen(),
              type: PageTransitionType.rightToLeftWithFade,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 500),
              reverseDuration: Duration(milliseconds: 500),
              opaque: true,
            );
            break;
          default:
            return null;
        }
      },
    );
  }
}
