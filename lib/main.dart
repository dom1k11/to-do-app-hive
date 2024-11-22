import 'package:flutter/material.dart';
import 'package:to_do_app_hive/hive/hive_init.dart';
import 'package:to_do_app_hive/screens/welcome_screen.dart';
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
      theme: ThemeData(
        hintColor: Colors.orange,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.orange),
          // Для крупного текста
          bodyMedium: TextStyle(color: Colors.orange),
          // Для стандартного текста
          bodySmall: TextStyle(color: Colors.orange),
          // Для мелкого текста
          headlineMedium: TextStyle(color: Colors.orange),
          // Заголовки
          titleLarge: TextStyle(color: Colors.orange), // Основной текст
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.orangeAccent), // Цвет для меток
          hintStyle: TextStyle(
              color: Colors.orangeAccent), // Цвет для подсказок (hint)
        ),
        listTileTheme: const ListTileThemeData(
          textColor: Colors.orange, // Цвет текста для заголовков
          iconColor: Colors.orange, // Цвет иконок
          subtitleTextStyle:
              TextStyle(color: Colors.orange), // Цвет текста в подзаголовках
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 53, 53, 53),
      ),
      home: isFirstLaunch ? WelcomeScreen() : const TasksScreen(),
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
