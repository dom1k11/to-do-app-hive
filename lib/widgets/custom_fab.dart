import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed, // Сделаем onPressed обязательным
  });

  final IconData icon;
  final Color color;
  final void Function() onPressed; // Тип для onPressed - функция без параметров

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 4,
      hoverElevation: 8,
      onPressed: onPressed, // Передаем функцию onPressed
      backgroundColor: color,
      child: Icon(icon),
    );
  }
}
