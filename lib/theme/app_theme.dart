import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
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
);