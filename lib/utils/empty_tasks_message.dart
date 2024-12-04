import 'package:flutter/material.dart';

class EmptyTasksMessage extends StatelessWidget {
  const EmptyTasksMessage({
    super.key,
    required double opacity,
  }) : _opacity = opacity;

  final double _opacity;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double textSize = (screenWidth / 25 ).clamp(12.0, 36.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 1000),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "You don't have any tasks, want to add a new one?",
                style: TextStyle(fontSize: textSize),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
