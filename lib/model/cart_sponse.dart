class CartResponse {
  final Store store;
  final List<CartItem> cartItems;

  CartResponse({required this.store, required this.cartItems});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      store: Store.fromJson(json),
      cartItems: (json['cart_items'] as List)
          .map((itemJson) => CartItem.fromJson(itemJson))
          .toList(),
    );
  }
}

class Store {
  final String uuid;
  final String name;
  final String image;

  Store({required this.uuid, required this.name, required this.image});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      uuid: json['uuid'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class CartItem {
  final int id;
  final String name;
  final int quantity;
  final String originalPrice;
  final String discountPrice;
  final String discountPercentage;
  final String size;
  final String color;
  final List<String> images;
  final CartItemOptions options;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.originalPrice,
    required this.discountPrice,
    required this.discountPercentage,
    required this.size,
    required this.color,
    required this.images,
    required this.options,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      originalPrice: json['original_price'],
      discountPrice: json['discount_price'],
      discountPercentage: json['discount_percentage'],
      size: json['size'],
      color: json['color'],
      images: List<String>.from(json['images']),
      options: CartItemOptions.fromJson(json['options']),
    );
  }
}

class CartItemOptions {
  final List<Option> sizes;
  final List<Option> colors;

  CartItemOptions({required this.sizes, required this.colors});

  factory CartItemOptions.fromJson(Map<String, dynamic> json) {
    return CartItemOptions(
      sizes: (json['sizes'] as List)
          .map((sizeJson) => Option.fromJson(sizeJson))
          .toList(),
      colors: (json['colors'] as List)
          .map((colorJson) => Option.fromJson(colorJson))
          .toList(),
    );
  }
}

class Option {
  final int id;
  final String name;
  final String? hexCode;

  Option({required this.id, required this.name, this.hexCode});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      name: json['name'],
      hexCode: json['hex_code'],
    );
  }
}
