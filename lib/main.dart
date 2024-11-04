import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

void main() {
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
          backgroundColor: Color.fromARGB(255, 255, 231, 76), // Цвет FloatingActionButton
        ),
        textTheme: const TextTheme(
          // bodyLarge: TextStyle(color: Color.fromARGB(255, 135, 137, 192)), // Цвет для bodyLarge текста
          bodyMedium: TextStyle(color: Color.fromARGB(255, 135, 137, 192)), // Цвет для bodyMedium текста
          // bodySmall: TextStyle(color: Color.fromARGB(255, 135, 137, 192)), // Цвет для bodySmall текста
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 53, 53, 53),
      ),
      home: const HomePage(),
    );
  }
}