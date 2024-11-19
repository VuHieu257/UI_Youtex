import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_youtex/bloc/product_bloc_bloc/product_bloc_bloc.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import '../../../core/colors/color.dart';

class ProductCard extends StatelessWidget {
  final ProductBuyer product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    print(product.fullImageUrl);

    return Card(
      color: Styles.colorF9F9F9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: product.fullImageUrl.isNotEmpty
                      ? NetworkImage(product.fullImageUrl) as ImageProvider
                      : const AssetImage('assets/images/default.png'),
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Product Name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          // Product Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),

          // Discount Percentage
          if (product.discountPercentage > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.discount_outlined,
                      color: Styles.nearPrimary, size: 16),
                  Text(
                    '${product.discountPercentage.toStringAsFixed(0)}%',
                    style: context.theme.textTheme.titleMedium
                        ?.copyWith(color: Styles.nearPrimary),
                  ),
                ],
              ),
            ),

          // Price and Sales
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '${NumberFormat("#,###").format(int.tryParse(product.discountPrice.toStringAsFixed(0)))}\t₫',
                    style: context.theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Text('Đã bán ${product.soldQuantity}',
                    style: context.theme.textTheme.titleSmall
                        ?.copyWith(color: Colors.grey)),
              ],
            ),
          ),

          // Original Price (if discounted)
          if (product.discountPrice < product.originalPrice)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '${product.originalPrice.toStringAsFixed(0)}₫',
                style: context.theme.textTheme.titleSmall?.copyWith(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
