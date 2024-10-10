import 'package:flutter/material.dart';
import 'package:ui_youtex/core/colors/color.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hình ảnh trên cùng
            Image.asset(
              'assets/images/Vector 1.png',
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 3.2,
              fit: BoxFit.cover,
            ),

            // Tiêu đề Đăng nhập
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Đăng nhập",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBE005B99),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Đăng nhập bằng tài khoản của bạn",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Form Email và Mật khẩu
                  TextField(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Color(0xFFB5B2B2)),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xFFBE005B99),
                      ),
                      hintText: "Email",
                      filled: true,
                      fillColor: Color(0xFFEEFBFF),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_clock_outlined,
                        color: Color(0xFFBE005B99),
                      ),
                      hintStyle: TextStyle(color: Color(0xFFB5B2B2)),
                      hintText: "Mật khẩu",
                      filled: true,
                      fillColor: Color(0xFFEEFBFF),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Checkbox ghi nhớ tài khoản
                  Row(
                    children: [
                      Checkbox(
                          focusColor: Color(0xFF00B2F6),
                          activeColor: Color(0xFF00B2F6),
                          shape: CircleBorder(),
                          value: true,
                          onChanged: (value) {}),
                      Text("Ghi nhớ tài khoản"),
                      Spacer(),
                      TextButton(
                        onPressed: () {Navigator.pushNamed(context, '/Forgot');},
                        child: Text(
                          "Quên mật khẩu?",
                          style: TextStyle(color: Color(0xFF00B2F6)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

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
                        Navigator.pushNamed(context, '/home'
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
                        'Đăng Nhập',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Điều hướng đến màn hình Đăng ký
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Bạn chưa có tài khoản? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          "Đăng ký",
                          style: TextStyle(color: Color(0xFF00B2F6)),
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
