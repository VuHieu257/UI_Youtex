import 'package:flutter/material.dart';
import 'package:ui_youtex/core/colors/color.dart';

class WelcomeScreen4 extends StatelessWidget {
  final VoidCallback onPressed;

  WelcomeScreen4({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Hình ảnh chính, với chiều rộng đầy đủ của màn hình
          Image.asset(
            'assets/images/Vector 1.png',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: 50), // Khoảng cách giữa ảnh và text

          // Text giới thiệu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Tham gia cộng đồng của chúng tôi và khám phá những công cụ may mặc tiên tiến nhất.",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333), // Màu chữ 333333
              ),
            ),
          ),

          SizedBox(height: 100), // Khoảng cách giữa text và nút bấm

          // Nút "Tạo tài khoản ngay"
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
              backgroundColor:
                  Color.fromARGB(255, 101, 193, 247), // Màu nút A4F86E
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Bo góc cho nút
              ),
            ),
            child: Text(
              "Tạo tài khoản ngay",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Styles.light, // Màu chữ trên nút
              ),
            ),
          ),
        ],
      ),
    );
  }
}
