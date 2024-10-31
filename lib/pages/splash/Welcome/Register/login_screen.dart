import 'package:flutter/material.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  Text(
                    "Đăng nhập",
                   style: context.theme.textTheme.headlineLarge?.copyWith(
                     fontSize: 30,
                     fontWeight: FontWeight.bold,
                     color: Styles.nearPrimary,
                   ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Đăng nhập bằng tài khoản của bạn",
                    style: context.theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Form Email và Mật khẩu
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 3
                        )
                      ]
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Styles.color005B99,
                        ),
                        hintText: "Email",
                        filled: true,
                        fillColor: const Color(0xFFEEFBFF),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:BorderSide.none
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 3
                          )
                        ]
                    ),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          // Icons.lock_clock_outlined,
                          Icons.punch_clock,
                          color: Styles.color005B99,
                        ),
                        suffixIcon: const Icon(Icons.visibility_off,color: Styles.color005B99,),
                        hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
                        hintText: "Mật khẩu",
                        filled: true,
                        fillColor: const Color(0xFFEEFBFF),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:BorderSide.none
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Checkbox ghi nhớ tài khoản
                  Row(
                    children: [
                      Checkbox(
                          focusColor: const Color(0xFF00B2F6),
                          activeColor: const Color(0xFF00B2F6),
                          shape: const CircleBorder(),
                          value: true,
                          onChanged: (value) {}),
                      Text("Ghi nhớ tài khoản",
                        style: context.theme.textTheme.titleSmall?.copyWith(

                      ),),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Forgot');
                        },
                        child: Text(
                          "Quên mật khẩu?",
                          style: context.theme.textTheme.titleSmall?.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Nút Đăng nhập
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context,
                          '/CustomNavBar'
                              '');
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      height: MediaQuery.sizeOf(context).height / 14,
                      decoration: BoxDecoration(
                        color: Styles.nearPrimary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:
                      const Text(
                        'Đăng Nhập',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Bạn chưa có tài khoản? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          "Đăng ký",
                          style: TextStyle(color: Color(0xFF00B2F6)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin:const EdgeInsets.symmetric(horizontal: 10),
                        height: 1,
                        width: context.width*0.2,
                        color: Colors.black,
                      ),
                      Text("Hoặc tiếp tục với",style: context.theme.textTheme.headlineSmall,),
                      Container(
                        height: 1,
                        margin:const EdgeInsets.symmetric(horizontal: 10),
                        width: context.width*0.2,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.facebook,
                          color: Colors.blue,
                          size: 55,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(Asset.iconGg1,height: 45,)
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context,
                              '/memberVip'
                                  '');
                        },
                        icon: const Icon(
                          Icons.apple,
                          color: Colors.black,
                          size: 55,
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
