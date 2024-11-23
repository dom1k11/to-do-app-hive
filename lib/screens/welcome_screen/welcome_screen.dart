import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app_hive/screens/welcome_screen/messages.dart';
import 'package:to_do_app_hive/widgets/custom_elevated_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _firstTextOpacity = 0;
  double _secondTextOpacity = 0;

  @override
  void initState() {
    super.initState();
    // Анимация появления текста
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _firstTextOpacity = 1.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _secondTextOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Welcome"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FirstMessage(firstTextOpacity: _firstTextOpacity),
                SecondMessage(secondTextOpacity: _secondTextOpacity),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomElevatedButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

