import 'package:flutter/material.dart';
import 'package:ui_youtex/core/colors/color.dart';

class WelcomeScreen4 extends StatelessWidget {
  final VoidCallback onPressed;

  const WelcomeScreen4({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/Vector 1.png',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          // Text giới thiệu
          const SizedBox(
            width: 300,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Tham gia cộng đồng của chúng tôi và khám phá những công cụ may mặc tiên tiến nhất.",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333), // Màu chữ 333333
                ),
              ),
            ),
          ),

          const SizedBox(height: 180),

          InkWell(
            onTap: onPressed,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.all(10),
                padding:const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color:  Color(0xff333333)
                ),
                child:const Icon(Icons.arrow_forward_ios,color: Colors.white,),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
