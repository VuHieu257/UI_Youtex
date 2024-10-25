import 'package:flutter/material.dart';

class WelcomeScreen3 extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  WelcomeScreen3({
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'assets/images/welcome-app-3.png',
          width: MediaQuery.sizeOf(context).width,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          bottom: 0,
          top: MediaQuery.of(context).size.width / 1 + 30,
          right: MediaQuery.of(context).size.width / 17,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
              onPressed: onPressed,
            ),
          ),
        ),
      ],
    ));
  }
}
