import 'package:flutter/material.dart';
import 'package:youtext_app/pages/screens/home/category/category_screen.dart';

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
      home: CategoryScreen(),
    );
  }
}



// class ProductScreen extends StatelessWidget {
//   ProductScreen({super.key});
//
//   final List<Map<String, dynamic>> products = [
//     {
//       'name': 'Máy May Một Kim',
//       'price': '123.000',
//       'image': 'https://via.placeholder.com/150',
//       'rating': 4.5,
//       'sales': 63
//     },
//     {
//       'name': 'Vải Cotton May Áo',
//       'price': '123.000',
//       'image': 'https://via.placeholder.com/150',
//       'rating': 5,
//       'sales': 63
//     },
//     {
//       'name': 'Máy May Một Kim',
//       'price': '123.000',
//       'image': 'https://via.placeholder.com/150',
//       'rating': 4,
//       'sales': 63
//     },
//     {
//       'name': 'Vải Cotton May Áo',
//       'price': '123.000',
//       'image': 'https://via.placeholder.com/150',
//       'rating': 5,
//       'sales': 63
//     },
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Tìm kiếm',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     prefixIcon: Icon(Icons.search),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Icon(Icons.shopping_cart),
//               SizedBox(width: 10),
//               Icon(Icons.account_circle),
//             ],
//           ),
//         ),
//         backgroundColor: Colors.blue,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Máy móc và thiết bị may',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.sort),
//                       onPressed: () {
//                         // Sort action
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.filter_list),
//                       onPressed: () {
//                         // Filter action
//                       },
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               padding: EdgeInsets.all(10),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 0.75,
//               ),
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 return ProductCard(product: products[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ProductCard extends StatelessWidget {
//   final Map<String, dynamic> product;
//
//   ProductCard({required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       elevation: 3,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//                 image: DecorationImage(
//                   image: NetworkImage(product['image']),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               product['name'],
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(
//               '₫${product['price']}',
//               style: TextStyle(color: Colors.blue, fontSize: 16),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               children: [
//                 Icon(Icons.star, color: Colors.orange, size: 16),
//                 Text('${product['rating']}'),
//                 Spacer(),
//                 Text('Đã bán ${product['sales']}', style: TextStyle(fontSize: 12)),
//               ],
//             ),
//           ),
//           SizedBox(height: 8),
//         ],
//       ),
//     );
//   }
// }