import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/product/product_detail_page.dart';
import 'package:ui_youtex/pages/screens/home/search_page/search_page.dart';

import '../../../core/assets.dart';
import '../../widget_small/product/product_card.dart';
import '../shopping_cart_page/shopping_cart_page.dart';
import 'category/category_screen.dart';

class HomeMall extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'name': 'Máy móc và thiết bị may', 'image': Asset.bgImageCategory},
    {'name': 'Vải và nguyên liệu', 'image': Asset.bgImageCategory},
    {'name': 'Dụng cụ may', 'image': Asset.bgImageCategory},
    {'name': 'Hệ thống hỗ trợ', 'image': Asset.bgImageCategory},
  ];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Máy May Một Kim',
      'price': '123.000',
      'image': Asset.bgImageProduct,
      'rating': 4.5,
      'sales': 63
    },
    {
      'name': 'Vải Cotton May Áo Phông',
      'price': '123.000',
      'image': Asset.bgImageProduct,
      'rating': 5,
      'sales': 63
    },
    {
      'name': 'Máy May Một Kim',
      'price': '123.000',
      'image': Asset.bgImageProduct,
      'rating': 4,
      'sales': 63
    },
    {
      'name': 'Vải Cotton May Áo',
      'price': '123.000',
      'image': Asset.bgImageProduct,
      'rating': 5,
      'sales': 63
    },
  ];

  HomeMall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              Asset.bgLogo,
              height: 40,
            ),
          ],
        ),
        actions: [
          InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ));
          }
          ,child: CircleAvatar(backgroundColor: Colors.grey.shade300,child: const Icon(Icons.search))),
          const SizedBox(width: 10),
          InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShoppingCartPage(),
                ));
          },child: CircleAvatar(backgroundColor: Colors.grey.shade300,child: const Icon(Icons.shopping_cart_outlined))),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: MediaQuery.of(context).size.height /9,
            //   padding: EdgeInsets.only(
            //       top: MediaQuery.of(context).padding.top + 10,
            //       left: MediaQuery.of(context).padding.left + 10,
            //       right: MediaQuery.of(context).padding.right + 10,
            //       bottom: 15),
            //   color: Styles.blue,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextField(
            //           onTap: () {
            //
            //           },
            //           decoration: InputDecoration(
            //             hintText: 'Tìm kiếm',
            //             border: OutlineInputBorder(
            //                 borderRadius: BorderRadius.circular(25),
            //                 borderSide: BorderSide.none),
            //             hintStyle: const TextStyle(color: Colors.grey),
            //             prefixIcon: const Icon(
            //               Icons.search,
            //               color: Colors.grey,
            //             ),
            //             filled: true,
            //             fillColor: Colors.white,
            //           ),
            //         ),
            //       ),
            //       const SizedBox(width: 10),
            //       InkWell(
            //           onTap: () => Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) => const ShoppingCartPage(),
            //               )),
            //           child: const Icon(
            //             Icons.shopping_cart_outlined,
            //             color: Styles.light,
            //           )),
            //       const SizedBox(width: 10),
            //       Image.asset(
            //         Asset.iconMessage,
            //         width: context.width * 0.06,
            //       ),
            //       // Image.asset(Asset.iconMessage),
            //     ],
            //   ),
            // ),
            // Banner Image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: context.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage(Asset.bgSlider),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Category Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Danh mục',
                style: context.theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: context.width * 0.32,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                              category: categories[index]['name']),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage(categories[index]['image']!),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: context.width * 0.2,
                            child: Text(
                              categories[index]['name']!,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.theme.textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
           const Padding(
             padding: EdgeInsets.symmetric(horizontal:16.0),
             child: Divider(),
           ),
            // Product Section Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Sản phẩm',
                style: context.theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            // Product Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: products[index]),
                          ));
                    },
                    child: ProductCard(product: products[index]));
              },
            ),
          ],
        ),
      ),
    );
  }
}
