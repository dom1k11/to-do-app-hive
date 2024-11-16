import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton({super.key});

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  double _opacity = 0.0;

  @override
  void initState() {
   Future.delayed(Duration(milliseconds: 500), () { //change to 1000*3
     setState(() {
       _opacity = 1.0;
     });
   }
   );
    super.initState();
  }
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInSine,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 135, 137, 192),
          foregroundColor: Color.fromARGB(255, 34, 34, 49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 12,
          textStyle: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/tasks_screen');
        },
        child: const Text("Start Creating Tasks"),
      ),
    );
  }
}
