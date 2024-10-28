import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ui_youtex/core/colors/color.dart';

class ResetpassdoneScreen extends StatelessWidget {
  const ResetpassdoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hình ảnh trên cùng
            Image.asset(
              'assets/images/Vector 1.png',
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 2.2,
              fit: BoxFit.cover,
            ),

            // Tiêu đề Đăng nhập
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "All done!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffbe005b99),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  // Text thông báo "All done!"

                  const SizedBox(height: 10),
                  const Text(
                    "Your password had been reset",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  // Icon checkmark
                  const SizedBox(height: 30),
                  const Icon(
                    Icons.check,
                    size: 140,
                    color: Colors.blue,
                  ),

                  // Nút quay lại Login
                  const SizedBox(height: 40),

                  // Nút Đăng nhập
                  Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height / 14,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF218FF2), // Light blue
                          Color(0xFF13538C), // Dark blue
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context,
                            '/login'
                            '');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Back to Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Điều hướng đến màn hình Đăng ký
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
