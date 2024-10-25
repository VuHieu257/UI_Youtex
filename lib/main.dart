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

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Image.asset(
//               Asset.bgLogo, // Update with your actual logo asset
//               height: 40,
//             ),
//             const Spacer(),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications_none),
//             onPressed: () {},
//           ),
//           const SizedBox(width: 10),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Doanh nghiệp nổi bật',
//                 style: Theme.of(context).textTheme.headlineLarge,
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                 height: 100,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: const [
//                     FeaturedCompanyCard(
//                       imageUrl: Asset.bgCustomer1,
//                       title: 'Vinatex',
//                     ),
//                     FeaturedCompanyCard(
//                       imageUrl: Asset.bgCustomer2,
//                       title: 'Viet Thang',
//                     ),
//                     FeaturedCompanyCard(
//                       imageUrl: Asset.bgCustomer3,
//                       title: 'Viet Tien',
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Card(
//                 child: Column(
//                   children: [
//                     ImageTextCard(
//                       imageUrl: Asset.bgCustomer4,
//                       title: 'THƯƠNG HIỆU DỆT MAY VIỆT 2024',
//                       description: '...',
//                     ),
//                     const Divider(),
//                     ImageTextCard(
//                       imageUrl: Asset.bgCustomer4,
//                       title: 'KHAI TRƯƠNG CHI NHÁNH THỨ 10',
//                       description: '...',
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Bài đăng nổi bật',
//                 style: Theme.of(context).textTheme.headlineLarge,
//               ),
//               const SizedBox(height: 10),
//               HighlightedPostCard(
//                 imageUrl: Asset.bgCustomer4,
//                 title: 'KỶ NIỆM 10 NĂM THÀNH LẬP HẢI ANH',
//                 description: 'Kỷ niệm 10 năm của công ty...',
//                 actions: ['Xem thêm', 'Nhận quà'],
//               ),
//               const SizedBox(height: 10),
//               HighlightedPostCard(
//                 imageUrl: Asset.bgCustomer4,
//                 title: 'CHUNG TAY CÙNG VINID XÂY TRƯỜNG MỚI',
//                 description: 'Cùng chung tay với VinID để xây trường mới...',
//                 actions: ['Xem thêm', 'Nhận quà'],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FeaturedCompanyCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;

//   const FeaturedCompanyCard({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 80,
//       margin: const EdgeInsets.only(right: 10),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundColor: Colors.white,
//             child: Image.asset(imageUrl, height: 40),
//           ),
//           const SizedBox(height: 5),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ImageTextCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String description;

//   const ImageTextCard({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//     required this.description,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.asset(
//               imageUrl,
//               width: 100,
//               height: 100,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: Theme.of(context).textTheme.headlineLarge,
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   description,
//                   style: Theme.of(context).textTheme.headlineLarge,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HighlightedPostCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String description;
//   final List<String> actions;

//   const HighlightedPostCard({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//     required this.description,
//     required this.actions,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
//             child: Image.asset(
//               imageUrl,
//               height: 150,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: Theme.of(context).textTheme.headlineLarge,
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   description,
//                   style: Theme.of(context).textTheme.headlineLarge,
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   children: [
//                     for (final action in actions)
//                       Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           child: Text(action),
//                         ),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
 