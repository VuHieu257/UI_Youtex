// product_response.dart
class ProductResponse {
  final String message;
  final List<Product> products;

  ProductResponse({
    required this.message,
    required this.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      message: json['message'] ?? '',
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
    );
  }
}

// product.dart
class Product {
  final int id;
  final String? image;
  final String name;
  final String? description;
  final int isActive;
  final int quantity;
  final int soldQuantity;
  final double originalPrice;
  final double discountPrice;
  final double discountPercentage;

  Product({
    required this.id,
    this.image,
    required this.name,
    this.description,
    required this.isActive,
    required this.quantity,
    required this.soldQuantity,
    required this.originalPrice,
    required this.discountPrice,
    required this.discountPercentage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      image: json['image'],
      name: json['name'] ?? '',
      description: json['description'],
      isActive: json['is_active'] ?? 0,
      quantity: json['quantity'] ?? 0,
      soldQuantity: json['sold_quantity'] ?? 0,
      originalPrice: (json['original_price'] ?? 0).toDouble(),
      discountPrice: (json['discount_price'] ?? 0).toDouble(),
      discountPercentage: (json['discount_percentage'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'description': description,
      'is_active': isActive,
      'quantity': quantity,
      'sold_quantity': soldQuantity,
      'original_price': originalPrice,
      'discount_price': discountPrice,
      'discount_percentage': discountPercentage,
    };
  }
}
