import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';

class WelcomeScreen3 extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const WelcomeScreen3({super.key, 
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
          top: MediaQuery.of(context).size.width / 1 + 40,
          right: MediaQuery.of(context).size.width / 24,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xff333333),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: onPressed,
            ),
          ),
        ),
      ],
    ));
  }
}
