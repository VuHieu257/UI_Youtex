class CheckoutResponse {
  final String message;
  final int quantity;
  final int total;
  final List<Store> stores;

  CheckoutResponse({
    required this.message,
    required this.quantity,
    required this.total,
    required this.stores,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      message: json['message'] ?? '',
      quantity: json['quantity'] ?? 0,
      total: json['total'] ?? 0,
      stores: (json['stores'] as List)
          .map((store) => Store.fromJson(store))
          .toList(),
    );
  }
}

class Store {
  final String uuid;
  final String name;
  final String image;
  final int quantity;
  final int total;
  final List<Product> products;

  Store({
    required this.uuid,
    required this.name,
    required this.image,
    required this.quantity,
    required this.total,
    required this.products,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? 0,
      total: json['total'] ?? 0,
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
    );
  }
}

class Product {
  final int id;
  final String uuid;
  final String image;
  final String name;
  final String? size;
  final String? color;
  final int quantity;
  final double originalPrice;
  final double discountPrice;
  final String discountPercentage;
  final dynamic options;
  final String updatedAt;
  final dynamic error;

  Product({
    required this.id,
    required this.uuid,
    required this.image,
    required this.name,
    this.size,
    this.color,
    required this.quantity,
    required this.originalPrice,
    required this.discountPrice,
    required this.discountPercentage,
    this.options,
    required this.updatedAt,
    this.error,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      uuid: json['uuid'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      size: json['size'],
      color: json['color'],
      quantity: json['quantity'] ?? 0,
      originalPrice: double.tryParse(json['original_price'].toString()) ?? 0.0,
      discountPrice: double.tryParse(json['discount_price'].toString()) ?? 0.0,
      discountPercentage: json['discount_percentage'] ?? '0',
      options: json['options'],
      updatedAt: json['updated_at'] ?? '',
      error: json['error'],
    );
  }
}
