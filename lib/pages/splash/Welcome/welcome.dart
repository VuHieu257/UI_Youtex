import 'package:flutter/material.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/RegisterScreen.dart';
import 'package:ui_youtex/pages/splash/Welcome/first_welcome.dart';
import 'package:ui_youtex/pages/splash/Welcome/fourth_welcome.dart';
import 'package:ui_youtex/pages/splash/Welcome/second_welcome.dart';
import 'package:ui_youtex/pages/splash/Welcome/third_welcome.dart';

class WelcomeApp extends StatefulWidget {
  const WelcomeApp({super.key});

  @override
  _WelcomeAppState createState() => _WelcomeAppState();
}

class _WelcomeAppState extends State<WelcomeApp> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        WelcomeScreen1(
            onPressed: () => _controller.nextPage(
                duration: const Duration(milliseconds: 300), curve: Curves.easeIn)),
        WelcomeScreen2(
            title: " ",
            subtitle: " ",
            onPressed: () => _controller.nextPage(
                duration: const Duration(milliseconds: 300), curve: Curves.easeIn)),
        WelcomeScreen3(
            title: " ",
            subtitle: " ",
            onPressed: () => _controller.nextPage(
                duration: const Duration(milliseconds: 300), curve: Curves.easeIn)),
        WelcomeScreen4(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterScreen())),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
