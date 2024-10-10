import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title Đăng ký
            const Text(
              "Đăng ký",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "Tạo tài khoản mới",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Form Họ và tên, Email, Mật khẩu
            TextField(
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Color(0xFFBEBEBE)),
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xFF3F8512),
                ),
                hintText: "Họ và tên",
                filled: true,
                fillColor: Color(0xFFA4F86E).withOpacity(0.3),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 15),
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Color(0xFFBEBEBE)),
                prefixIcon: Icon(
                  Icons.lock_clock_outlined,
                  color: Color(0xFF3F8512),
                ),
                hintText: "Mật khẩu",
                filled: true,
                fillColor: Color(0xFFA4F86E).withOpacity(0.3),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Color(0xFFBEBEBE)),
                prefixIcon: Icon(
                  Icons.lock_clock_outlined,
                  color: Color(0xFF3F8512),
                ),
                hintText: "Nhập lại mật khẩu",
                filled: true,
                fillColor: Color(0xFFA4F86E).withOpacity(0.3),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 15),

            // Checkbox đồng ý với điều khoản
            Row(
              children: [
                Checkbox(
                    shape: CircleBorder(), value: false, onChanged: (value) {}),
                Text("Đồng ý với điều khoản sử dụng"),
              ],
            ),
            SizedBox(height: 20),

            // Nút Đăng ký
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Đăng Ký",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Color(0xFFA4F86E),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Nút liên kết với Facebook, Google, Apple
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.facebook,
                    color: Colors.blue,
                    size: 55,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.g_translate,
                    color: Colors.red,
                    size: 55,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.apple,
                    color: Colors.black,
                    size: 55,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Điều hướng đến màn hình Đăng nhập
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Bạn đã có tài khoản? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}