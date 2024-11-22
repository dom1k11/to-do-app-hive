import 'package:flutter/material.dart';
import 'package:to_do_app_hive/hive/hive_init.dart';
import 'package:to_do_app_hive/screens/welcome_screen.dart';
import 'package:to_do_app_hive/theme/app_theme.dart';
import 'package:to_do_app_hive/utils/first_launch_check.dart';
import 'package:to_do_app_hive/utils/routes/routes.dart';
import '../screens/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeHive();
  bool isFirstLaunch = await firstLaunchChecking();
  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstLaunch});

  final bool isFirstLaunch;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: isFirstLaunch ? WelcomeScreen() : const TasksScreen(),
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
