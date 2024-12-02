import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app_hive/models/task_model.dart';
import 'package:to_do_app_hive/screens/welcome_screen/welcome_screen.dart';
import 'package:to_do_app_hive/theme/app_theme.dart';
import 'package:to_do_app_hive/utils/first_launch_check.dart';
import 'package:to_do_app_hive/utils/routes/routes.dart';
import 'screens/tasks_screen/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Hive.initFlutter();
    print("Hive initialized");
  } catch (e) {
    print('Error initializing Hive: $e');
  }
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('tasksBox');
  await Hive.openBox<Task>('completedTasksBox');
  bool isFirstLaunch = await firstLaunchChecking();
  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstLaunch});

  final bool isFirstLaunch;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: isFirstLaunch ? const WelcomeScreen() : const TasksScreen(),
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
