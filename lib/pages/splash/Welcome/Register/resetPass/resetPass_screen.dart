import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ui_youtex/core/colors/color.dart';

class ResetpassScreen extends StatelessWidget {
  const ResetpassScreen({super.key});

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
                    "Set New Password",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffbe005b99),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Trường mật khẩu
                  TextField(
                    obscureText: true, // Che mật khẩu
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xffbe005b99), // Icon khóa cho mật khẩu
                      ),
                      hintText: "******",
                      filled: true,
                      fillColor: const Color(0xFFEEFBFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Row(
                    children: [
                      Text(
                        "Confirm password",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Trường xác nhận mật khẩu
                  TextField(
                    obscureText: true, // Che mật khẩu
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xffbe005b99), // Icon khóa cho mật khẩu
                      ),
                      hintText: "******",
                      filled: true,
                      fillColor: const Color(0xFFEEFBFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),

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
                            '/Resetpass'
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
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Điều hướng đến màn hình Đăng ký
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          "<- Back to Login",
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
