part of 'product_bloc_bloc.dart';

sealed class ProductBlocEvent extends Equatable {
  const ProductBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchProductsEvent extends ProductBlocEvent {
  const FetchProductsEvent();

  @override
  List<Object> get props => [];
}

class SearchProductsEvent extends ProductBlocEvent {
  final String searchQuery;

  const SearchProductsEvent(this.searchQuery);

  @override
  List<Object> get props => [searchQuery];
}

class ProductBuyer extends Equatable {
  final String? uuid; // Changed to accept String
  final String image;
  final String name;
  final String description;
  final int quantity;
  final int soldQuantity;
  final double originalPrice;
  final double discountPrice;
  final double discountPercentage;

  const ProductBuyer({
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

  factory ProductBuyer.fromJson(Map<String, dynamic> json) {
    return ProductBuyer(
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

class ProductDetailBuyer extends ProductBlocEvent {
  final String uuId;

  const ProductDetailBuyer({required this.uuId});
  @override
  List<Object> get props => [uuId];
}
