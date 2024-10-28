import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/pages/screens/home/home.dart';
import 'package:ui_youtex/pages/screens/member_Vip/free_trail.dart';
import 'package:ui_youtex/pages/screens/member_Vip/member_packagePayment.dart';
import 'package:ui_youtex/pages/screens/message/chat/chat_screen.dart';
import 'package:ui_youtex/pages/screens/message/new_chat_screen.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen%20copy.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_mail/user_mail_shop_product.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/RegisterScreen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/forgotPass_Screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPassDone_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPassOtp_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPass_screen.dart';
import 'package:ui_youtex/pages/widget_small/bottom_navigation/bottom_navigation.dart';

import 'core/themes/theme_data.dart';
import 'pages/splash/Welcome/Register/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCU66WlqitlSdBipwdwb_69uuRnJNupI0s',
          appId: '1:57983356211:android:5fd331cd4ef5361fea4246',
          messagingSenderId: '57983356211',
          projectId: 'mangxahoi-sotavn',
          storageBucket: "mangxahoi-sotavn.appspot.com"
      )) :
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyAppThemes.lightTheme,
      debugShowCheckedModeBanner: false,

      // home: HomePage(),
      // home: WelcomeApp(),
      // home: const CustomNavBar(),
      home: const ChatScreen( receiverId: "aaaa",),
      // home: CustomBackground(),
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
        '/PaymentMethodScreen': (context) => const PaymentMethodScreen(),
        '/PaymentMethodPayScreen': (context) => const PaymentMethodPayScreen(),
        '/product_management': (context) => ProductManagementScreen(),
      },
    );
  }
}

