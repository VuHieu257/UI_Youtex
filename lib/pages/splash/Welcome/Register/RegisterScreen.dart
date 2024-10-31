import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';

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
                color: Color(0xFF005B99),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "Tạo tài khoản mới",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

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
                    Icons.person,
                    color: Styles.color005B99,
                  ),
                  hintText: "Số điện thoại",
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
            textField(Icons.email,"Email"),
            const SizedBox(height: 15),
            textField(Icons.punch_clock,"Mật khẩu",iconRight: Icons.visibility_off),
            const SizedBox(height: 15),
            textField(Icons.punch_clock,"Nhập lại mật khẩu",iconRight: Icons.visibility_off),
            const SizedBox(height: 15),

            Row(
              children: [
                Checkbox(
                    activeColor: const Color(0xFF00B2F6),
                    value: true,
                    onChanged: (value) {}),
                const Text("Đồng ý với điều khoản sử dụng"),
              ],
            ),
            const SizedBox(height: 20),

            InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context,
                    '/memberVip'
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
                  'Đăng Ký',
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
            const SizedBox(height: 20),

            // Điều hướng đến màn hình Đăng nhập
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Bạn đã có tài khoản? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    "Đăng nhập",
                    style: TextStyle(color: Color(0xFF00B2F6)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget textField(IconData icon,String hintText,{IconData? iconRight}){
    return Container(
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
          prefixIcon: Icon(
            icon,
            color: Styles.color005B99,
          ),
          suffixIcon:iconRight!=null? Icon(iconRight,color: Styles.color005B99,):null,
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xFFEEFBFF),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:BorderSide.none
          ),
        ),
      ),
    );
  }
}
