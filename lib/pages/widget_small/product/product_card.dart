import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../core/colors/color.dart';
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Styles.light,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage(product['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.theme.textTheme.titleMedium,
              // style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '₫${product['price']}',
              style: context.theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.blue
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                Text('${product['rating']}',
                  style: context.theme.textTheme.titleMedium?.copyWith(
                  ),),
                const Spacer(),
                Text('Đã bán ${product['sales']}',
                    style: context.theme.textTheme.titleSmall?.copyWith(
                        color: Colors.grey
                    )),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
