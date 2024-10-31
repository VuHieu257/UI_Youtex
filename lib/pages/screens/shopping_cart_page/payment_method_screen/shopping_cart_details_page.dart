import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';

class ShoppingCartPagedetails extends StatefulWidget {
  const ShoppingCartPagedetails({super.key});

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPagedetails> {
  final List<bool> _isSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.grid_view, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Số lượng sản phẩm và bộ lọc
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '52,082+ sản phẩm',
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.sort, color: Styles.grey),
                    SizedBox(width: 8),
                    Text('Lọc', style: context.theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: 6, // Giả sử có 6 sản phẩm
                itemBuilder: (context, index) {
                  return ProductCart(
                    imageUrl: Asset.bgImageProduct,
                    name: 'Vải thun cotton 4 chiều',
                    price: 150000,
                    rating: 4.2,
                    soldCount: 1400,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget mô phỏng cho từng sản phẩm
class ProductCart extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final double rating;
  final int soldCount;

  const ProductCart({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.soldCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, maxLines: 2, overflow: TextOverflow.ellipsis),
                Text(
                  '${price.toStringAsFixed(0)}đ',
                  style: TextStyle(
                    color: Styles.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 14),
                    SizedBox(width: 4),
                    Text('$rating'),
                    Spacer(),
                    Text('Đã bán $soldCount'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
