import 'package:flutter/material.dart';

class WelcomeScreen1 extends StatelessWidget {
  final VoidCallback onPressed;

  WelcomeScreen1({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome-app-1 (2).png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Positioned button at the bottom
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
