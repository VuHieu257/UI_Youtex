import 'dart:convert';

class Cart {
  final String message;
  final int quantity;
  final int total;
  final List<Store> stores;

  Cart({
    required this.message,
    required this.quantity,
    required this.total,
    required this.stores,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var storeList = json['stores'] as List;
    List<Store> stores = storeList.map((i) => Store.fromJson(i)).toList();

    return Cart(
      message: json['message'],
      quantity: json['quantity'],
      total: json['total'],
      stores: stores,
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
    var productList = json['products'] as List;
    List<Product> products = productList.map((i) => Product.fromJson(i)).toList();

    return Store(
      uuid: json['uuid'],
      name: json['name'],
      image: json['image'],
      quantity: json['quantity'],
      total: json['total'],
      products: products,
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
  final String originalPrice;
  final String discountPrice;
  final String discountPercentage;

  Product({
    required this.id,
    required this.uuid,
    required this.image,
    required this.name,
    required this.size,
    required this.color,
    required this.quantity,
    required this.originalPrice,
    required this.discountPrice,
    required this.discountPercentage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      uuid: json['uuid']??"",
      image: json['image']??"",
      name: json['name']??"",
      size: json['size']??"",
      color: json['color']??"",
      quantity: json['quantity']??"",
      originalPrice: json['original_price']??"",
      discountPrice: json['discount_price']??"",
      discountPercentage: json['discount_percentage']??"",
    );
  }
}