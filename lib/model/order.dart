class Order {
  final String orderUuid;
  final String orderStatus;
  final String paymentStatus;
  final List<Store> stores;

  Order({
    required this.orderUuid,
    required this.orderStatus,
    required this.paymentStatus,
    required this.stores,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var storeList = json['stores'] as List;
    List<Store> storeItems = storeList.map((i) => Store.fromJson(i)).toList();

    return Order(
      orderUuid: json['order_uuid'],
      orderStatus: json['order_status'],
      paymentStatus: json['payment_status'],
      stores: storeItems,
    );
  }
}

class Store {
  final String storeUuid;
  final String storeName;
  final String storeImage;
  final int totalQuantity;
  final int totalPrice;
  final Product product;

  Store({
    required this.storeUuid,
    required this.storeName,
    required this.storeImage,
    required this.totalQuantity,
    required this.totalPrice,
    required this.product,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeUuid: json['store_uuid'],
      storeName: json['store_name'],
      storeImage: json['store_image'],
      totalQuantity: json['total_quantity'],
      totalPrice: json['total_price'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
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
    required this.uuid,
    required this.image,
    required this.name,
    this.size,
    this.color,
    required this.quantity,
    required this.originalPrice,
    required this.discountPrice,
    required this.discountPercentage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      uuid: json['uuid'],
      image: json['image'],
      name: json['name'],
      size: json['size'],
      color: json['color'],
      quantity: json['quantity'],
      originalPrice: json['original_price'],
      discountPrice: json['discount_price'],
      discountPercentage: json['discount_percentage'],
    );
  }
}