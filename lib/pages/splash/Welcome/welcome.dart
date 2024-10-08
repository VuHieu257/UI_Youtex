 
import 'package:flutter/material.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/RegisterScreen.dart';
import 'package:ui_youtex/pages/splash/Welcome/first_welcome.dart';
import 'package:ui_youtex/pages/splash/Welcome/fourth_welcome.dart';
import 'package:ui_youtex/pages/splash/Welcome/second_welcome.dart';
import 'package:ui_youtex/pages/splash/Welcome/third_welcome.dart';

class WelcomeApp extends StatefulWidget {
  @override
  _WelcomeAppState createState() => _WelcomeAppState();
}

class _WelcomeAppState extends State<WelcomeApp> {
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        WelcomeScreen1(
            onPressed: () => _controller.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeIn)),
        WelcomeScreen2(
            title: "Cà Phê Thơm Ngon, Điểm Tích Trọn",
            subtitle: "Uống Một Ly, Tích Một Điểm",
            onPressed: () => _controller.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeIn)),
        WelcomeScreen3(
            title: "Cà Phê Mỗi Ngày, Niềm Vui Trọn Vẹn",
            subtitle: "Thưởng Thức & Tích Lũy",
            onPressed: () => _controller.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeIn)),
        WelcomeScreen4(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterScreen())),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
