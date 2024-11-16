import 'package:flutter/material.dart';
import 'package:to_do_app_hive/widgets/custom_elevated_button.dart';
import 'package:to_do_app_hive/widgets/custom_fab.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  double _textOpacity = 0;
  double _secondTextOpacity = 0;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _textOpacity = 1.0;
      });
    });
    Future.delayed(Duration(milliseconds: 1000 * 2), () {
      setState(() {
        _secondTextOpacity = 1.0;
      });
    });
    super.initState();
  }

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
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: _textOpacity,
                    duration: Duration(milliseconds: 1000),
                    child: Text("Hello"),
                  ),
                  AnimatedOpacity(
                    opacity: _secondTextOpacity,
                    duration: Duration(milliseconds: 1000),
                    child: const Text("Welcome to my app"),
                  ),
                ],
              ),
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
