import 'package:flutter/material.dart';

class WelcomeScreen2 extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  WelcomeScreen2({
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
            'assets/images/welcome-app-1.png',
            width: 3000,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            bottom: 0,
            top: MediaQuery.of(context).size.width / 1 + 40,
            right: MediaQuery.of(context).size.width / 24,
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
      ),
    );
  }
}
