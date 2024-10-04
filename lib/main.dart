import 'package:flutter/material.dart';
import 'package:ui_youtex/pages/screens/fanpage/avatar/Setting/SettingsPage.dart';
import 'package:ui_youtex/pages/screens/fanpage/avatar/ava_anhbia.dart';
import 'package:ui_youtex/pages/screens/fanpage/avatar/profile_fangape.dart';
import 'package:ui_youtex/pages/screens/fanpage/fanpage-description.dart';
import 'package:ui_youtex/pages/screens/fanpage/fanpage.dart';
import 'package:ui_youtex/pages/screens/fanpage/fanpage_infor.dart';
import 'package:ui_youtex/pages/screens/fanpage/name_fanpage.dart';
import 'package:ui_youtex/pages/screens/home/adress/adress_add_screen.dart';
import 'package:ui_youtex/pages/screens/home/adress/adress_screen.dart';
import 'package:ui_youtex/pages/screens/home/group_chat/group_chat_view.dart';
import 'package:ui_youtex/pages/screens/home/group_chat/search_message.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/shopping_cart_page.dart';

import 'core/assets.dart';
import 'core/themes/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      home: ShoppingCartPage(),
    );
  }
}
// class PaymentMethodScreen extends StatefulWidget {
//   const PaymentMethodScreen({super.key});
//
//   @override
//   _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
// }
//
// class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
//   int _selectedCardIndex = 0; // Default selected card index
//
//   List<Map<String, String>> savedCards = [
//     {'type': 'VISA', 'number': '**** **** **** 2512', 'isDefault': 'true'},
//     {'type': 'MasterCard', 'number': '**** **** **** 5421', 'isDefault': 'false'},
//     {'type': 'VISA', 'number': '**** **** **** 2512', 'isDefault': 'false'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Styles.blue,
//         centerTitle: true,
//         leading: InkWell(onTap: () => Navigator.pop(context),child: const Icon(Icons.arrow_back_ios,color: Styles.light,)),
//         title: Text('Phương thức thanh toán',style: context.theme.textTheme.titleMedium?.copyWith(
//           fontWeight: FontWeight.bold,
//           color: Styles.light,
//         ),),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             // Saved Cards List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: savedCards.length,
//                 itemBuilder: (context, index) {
//                   var card = savedCards[index];
//                   return CardOption(
//                     cardType: card['type']!,
//                     cardNumber: card['number']!,
//                     isSelected: _selectedCardIndex == index,
//                     isDefault: card['isDefault'] == 'true',
//                     onTap: () {
//                       setState(() {
//                         _selectedCardIndex = index;
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//             // Add New Card Button
//             Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.all(5),
//               decoration: BoxDecoration(borderRadius:BorderRadius.circular(16),border: Border.all( width: 1,color: Styles.grey)),
//               child: TextButton.icon(
//                 onPressed: () {
//                   // Handle adding a new card
//                 },
//                 icon: const Icon(Icons.add, color: Colors.black87),
//                 label: Text('Thêm thẻ mới',style: context.theme.textTheme.titleMedium?.copyWith( ),),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Save Button
//             const CusButton(text:"Lưu",color:Styles.blue),
//
//           ],
//         ),
//       ),
//     );
//   }
// }

// Card Option Widget
