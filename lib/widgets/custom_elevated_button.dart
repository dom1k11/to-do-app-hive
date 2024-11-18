import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton({super.key});

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  double _opacity = 0.0;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000 * 3), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInSine,
      child: Container(
        width: 200,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            foregroundColor: const Color.fromARGB(255, 34, 34, 49),
            //text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 12,
            textStyle: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/tasks_screen');
          },
          child: const Text("Start Creating Tasks"),
        ),
      ),
    );
  }
}
