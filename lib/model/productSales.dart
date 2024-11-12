import 'package:dio/dio.dart';

class ProductSales {
  final String productId;
  final String originalPrice;
  final String discountPrice;
  final String quantity;
  final String minOrder;
  final String maxOrder;
  final String? sizeChart;

  ProductSales({
    required this.productId,
    required this.originalPrice,
    required this.discountPrice,
    required this.quantity,
    required this.minOrder,
    required this.maxOrder,
    this.sizeChart,
  });

  Map<String, dynamic> toFormData() {
    return {
      'product_id': productId,
      'original_price': originalPrice,
      'discount_price': discountPrice,
      'quantity': quantity,
      'min_order': minOrder,
      'max_order': maxOrder,
      'size_chart': sizeChart != null ? MultipartFile.fromFileSync(sizeChart!) : null,
    };
  }
}
