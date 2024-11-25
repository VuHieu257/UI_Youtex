part of 'product_store_bloc.dart';

abstract class ProductStoreBlocEvent extends Equatable {
  const ProductStoreBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchProductsEvent extends ProductStoreBlocEvent {
  final String uuid; // Thêm trường uuid

  const FetchProductsEvent({required this.uuid});

  @override
  List<Object> get props => [uuid];
}

class SearchProductsEvent extends ProductStoreBlocEvent {
  final String searchQuery;

  const SearchProductsEvent(this.searchQuery);

  @override
  List<Object> get props => [searchQuery];
}

class ProductDetailBuyerEvent extends ProductStoreBlocEvent {
  final String uuId;

  const ProductDetailBuyerEvent({required this.uuId});

  @override
  List<Object> get props => [uuId];
}

class ProductStore extends Equatable {
  final String? uuid; // Changed to accept String
  final String image;
  final String name;
  final String description;
  final int quantity;
  final int soldQuantity;
  final double originalPrice;
  final double discountPrice;
  final double discountPercentage;

  const ProductStore({
    this.uuid, // Made optional since it could be null
    required this.image,
    required this.name,
    required this.description,
    required this.quantity,
    required this.soldQuantity,
    required this.originalPrice,
    required this.discountPrice,
    required this.discountPercentage,
  });

  factory ProductStore.fromJson(Map<String, dynamic> json) {
    return ProductStore(
      uuid: json['uuid'],
      image: json['image'] ?? '', // Nếu null trả về chuỗi rỗng
      name: json['name'] ?? 'Unknown Product',
      description: json['description'] ?? '',
      quantity: json['quantity'] ?? 0,
      soldQuantity: json['sold_quantity'] ?? 0,
      originalPrice:
          double.tryParse(json['original_price']?.toString() ?? '0') ?? 0,
      discountPrice:
          double.tryParse(json['discount_price']?.toString() ?? '0') ?? 0,
      discountPercentage:
          double.tryParse(json['discount_percentage']?.toString() ?? '0') ?? 0,
    );
  }
  String get fullImageUrl {
    if (image.isEmpty) return '';
    if (image.startsWith('http')) return image;

    final cleanImagePath =
        image.startsWith('images/') ? image : 'images/$image';
    return '${NetworkConstants.STORAGE_URL}$cleanImagePath';
  }

  @override
  List<Object?> get props => [
        uuid,
        image,
        name,
        description,
        quantity,
        soldQuantity,
        originalPrice,
        discountPrice,
        discountPercentage,
      ];
}

class ProductStoreDetailBuyer extends ProductStoreBlocEvent {
  final String uuId;

  const ProductStoreDetailBuyer({required this.uuId});
  @override
  List<Object> get props => [uuId];
}
