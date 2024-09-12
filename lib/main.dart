import 'package:flutter/material.dart';
import 'package:youtext_app/core/colors/color.dart';
import 'package:youtext_app/core/size/size.dart';
import 'package:youtext_app/core/themes/theme_extensions.dart';
import 'package:youtext_app/pages/screens/home/category/category_screen.dart';
import 'package:youtext_app/pages/screens/home/home.dart';
import 'package:youtext_app/pages/screens/shopping_cart_page/checkout_page/checkout_page.dart';
import 'package:youtext_app/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen.dart';
import 'package:youtext_app/pages/screens/shopping_cart_page/shopping_cart_page.dart';
import 'package:youtext_app/pages/widget_small/custom_button.dart';

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
      home: HomePage(),
      // home: const CheckoutPage(),
      // home: const SearchPage(),
    );
  }
}
// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});
//
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   List<String> recentSearches = ['Vải áo thun', 'Vải áo sơ mi', 'Vải áo khoác'];
//
//   // This method removes a single recent search item
//   void removeSearchItem(int index) {
//     setState(() {
//       recentSearches.removeAt(index);
//     });
//   }
//
//   // This method clears all recent searches
//   void clearAllSearches() {
//     setState(() {
//       recentSearches.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).padding.top+10,
//                 left: MediaQuery.of(context).padding.left+10,
//                 right: MediaQuery.of(context).padding.right+10,
//                 bottom: 15
//             ),
//             color: Styles.blue,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Tìm kiếm',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                           borderSide: BorderSide.none
//                       ),
//                       hintStyle: const TextStyle(color: Colors.grey),
//                       prefixIcon: const Icon(Icons.search,color: Colors.grey,),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 InkWell(onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const ShoppingCartPage(),)),child: const Icon(Icons.shopping_cart_outlined,color: Styles.light,)),
//                 const SizedBox(width: 10),
//                 Image.asset(Asset.iconMessage,width: context.width*0.06,),
//                 // Image.asset(Asset.iconMessage),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Recent Searches',
//                   style: context.theme.textTheme.headlineSmall?.copyWith(
//                     fontWeight: FontWeight.bold
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: clearAllSearches,
//                   child: Text(
//                     'Xóa tất cả' ,
//                     style: context.theme.textTheme.titleMedium?.copyWith(
//                   ),),
//                 ),
//               ],
//             ),
//           ),
//           ListView.builder(
//             itemCount: recentSearches.length,
//             physics: const NeverScrollableScrollPhysics(),
//             primary: true,
//             shrinkWrap: true,
//             padding: EdgeInsets.zero,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Row(
//                   children: [
//                     Text(recentSearches[index],style: context.theme.textTheme.headlineSmall,),
//                     const Spacer(),
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () {
//                         removeSearchItem(index);
//                       },
//                     )
//                   ],
//                 ),
//                 subtitle: const Divider(),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }



