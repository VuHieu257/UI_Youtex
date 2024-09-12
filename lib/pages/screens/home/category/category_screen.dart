import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';
import '../../../../core/size/size.dart';
import '../../../widget_small/product/product_card.dart';
import '../../shopping_cart_page/shopping_cart_page.dart';


class CategoryScreen extends StatefulWidget {
  String? category;
  CategoryScreen({super.key,required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Map<String, String>> categories = [
    {'name': 'Máy móc và thiết bị may', 'image':  Asset.bgImageCategory},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => hideKeyBoard(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top+10,
                    left: MediaQuery.of(context).padding.left+15,
                    right: MediaQuery.of(context).padding.right+10,
                    bottom: 15
                ),
                color: Styles.blue,
                child: Row(
                  children: [
                    InkWell(onTap: () => Navigator.pop(context),child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none
                          ),
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.search,color: Colors.grey,),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const ShoppingCartPage(),)),child: const Icon(Icons.shopping_cart_outlined,color: Styles.light,)),
                    const SizedBox(width: 10),
                    // const Icon(Icons.message_outlined,color: Styles.light,),
                    Image.asset(Asset.iconMessage,width: context.width*0.06,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                child: Row(
                  children: [
                    Text(
                      "${widget.category}",
                      style: context.theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(right: 13),
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      decoration: BoxDecoration(
                        color: Styles.light,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8
                            )
                          ]
                      ),
                      child:Row(
                        children: [
                          Text(
                            'Loại',
                            style: context.theme.textTheme.titleSmall?.copyWith(
                            ),
                          ),
                          const Icon(Icons.compare_arrows),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      decoration: BoxDecoration(
                          color: Styles.light,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8
                            )
                          ]
                      ),
                      child:Row(
                        children: [
                          Text(
                            'Lọc',
                            style: context.theme.textTheme.titleSmall?.copyWith(
                            ),
                          ),
                          const Icon(Icons.filter_list_alt),
                        ],
                      ),
                    )
                  ],
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
                  return ProductCard(product: products[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
