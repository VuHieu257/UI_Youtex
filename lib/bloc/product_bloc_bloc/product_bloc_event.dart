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
      image: json['image'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      soldQuantity: json['sold_quantity'],
      originalPrice: double.parse(json['original_price']),
      discountPrice: double.parse(json['discount_price']),
      discountPercentage: double.parse(json['discount_percentage']),
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
