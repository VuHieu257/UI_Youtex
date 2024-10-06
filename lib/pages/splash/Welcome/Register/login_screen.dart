import 'package:flutter/material.dart';

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
              fit: BoxFit.cover,
            ),

            // Tiêu đề Đăng nhập
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Đăng nhập",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Đăng nhập bằng tài khoản của bạn",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),

                  // Form Email và Mật khẩu
                  TextField(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Color(0xFFBEBEBE)),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xFF3F8512),
                      ),
                      hintText: "Email",
                      filled: true,
                      fillColor: Color(0xFFA4F86E).withOpacity(0.3),
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
                        color: Color(0xFF3F8512),
                      ),
                      hintStyle: TextStyle(color: Color(0xFFBEBEBE)),
                      hintText: "Mật khẩu",
                      filled: true,
                      fillColor: Color(0xFFA4F86E).withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Checkbox ghi nhớ tài khoản
                  Row(
                    children: [
                      Checkbox(
                          shape: CircleBorder(),
                          value: false,
                          onChanged: (value) {}),
                      Text("Ghi nhớ tài khoản"),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Quên mật khẩu?",
                          style: TextStyle(color: Color(0xFFA4F86E)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Nút Đăng nhập
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Text(
                        "Đăng nhập",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Color(0xFFA4F86E),
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
                          style: TextStyle(color: Colors.green),
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
