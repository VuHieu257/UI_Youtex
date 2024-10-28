import 'package:flutter/material.dart';
import 'dart:core';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/home.dart';
import 'package:ui_youtex/pages/screens/home/homepage.dart';
import 'package:ui_youtex/pages/screens/member_Vip/free_trail.dart';
import 'package:ui_youtex/pages/screens/member_Vip/member_packagePayment.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen%20copy.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_mail/user_mail_shop_product.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/RegisterScreen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/forgotPass_Screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPassDone_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPassOtp_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPass_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/welcome.dart';

import 'package:ui_youtex/pages/widget_small/bottom_navigation/bottom_navigation.dart';

import 'core/themes/theme_data.dart';
import 'pages/splash/Welcome/Register/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyAppThemes.lightTheme,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      debugShowCheckedModeBanner: false,

      // home: HomePage(),
      home: WelcomeApp(),
      // home: MembershipPaymentScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomePage(),
        '/memberVip': (context) => FreeTrialTimeline(),
        '/CustomNavBar': (context) => CustomNavBar(),
        '/Forgot': (context) => ForgotScreen(),
        '/OTP': (context) => OTPScreen(),
        '/Reset': (context) => ResetpassScreen(),
        '/Resetpass': (context) => ResetpassdoneScreen(),
        '/MembershipPaymentScreen': (context) => MembershipPaymentScreen(),
        '/PaymentMethodScreen': (context) => PaymentMethodScreen(),
        '/PaymentMethodPayScreen': (context) => PaymentMethodPayScreen(),
        '/product_management': (context) => ProductManagementScreen(),
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe
              ? Colors.lightBlueAccent.shade100.withOpacity(0.5)
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: context.width * 0.65,
          child: Text(
            message,
            style: const TextStyle(
              color: Styles.light,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
