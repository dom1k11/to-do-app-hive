import 'package:flutter/material.dart';

class SecondMessage extends StatelessWidget {
  const SecondMessage({
    super.key,
    required double secondTextOpacity,
  }) : _secondTextOpacity = secondTextOpacity;

  final double _secondTextOpacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _secondTextOpacity,
      duration: const Duration(milliseconds: 1000),
      child: const Text(
        "Welcome to my app",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class FirstMessage extends StatelessWidget {
  const FirstMessage({
    super.key,
    required double firstTextOpacity,
  }) : _firstTextOpacity = firstTextOpacity;

  final double _firstTextOpacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _firstTextOpacity,
      duration: const Duration(milliseconds: 1000),
      child: const Text(
        "Hello",
        style: TextStyle(fontSize: 48),
      ),
    );
  }
}