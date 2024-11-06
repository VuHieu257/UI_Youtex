part of 'seller_register_product_bloc_bloc.dart';

@immutable
sealed class SellerRegisterProductBlocEvent {}

class SellerRegisterProductGetEvent extends SellerRegisterProductBlocEvent {}

class SellerRegisterProductPostEvent extends SellerRegisterProductBlocEvent {
  final ProductPostModel model;

  SellerRegisterProductPostEvent({required this.model});
}

// Models
class SellerRegisterProductModel {
  final int id;
  final String image;
  final String name;
  final bool isActive;
  final int quantity;
  final int soldQuantity;
  final double originalPrice;
  final double discountPrice;
  final int discountPercentage;
  final String description;

  const SellerRegisterProductModel({
    required this.quantity,
    required this.soldQuantity,
    required this.originalPrice,
    required this.discountPrice,
    required this.discountPercentage,
    required this.description,
    required this.id,
    required this.image,
    required this.name,
    required this.isActive,
  });

  String get fullImageUrl {
    if (image.isEmpty) return '';
    if (image.startsWith('http')) return image;

    final cleanImagePath =
        image.startsWith('images/') ? image : 'images/$image';
    return '${NetworkConstants.STORAGE_URL}$cleanImagePath';
  }

  factory SellerRegisterProductModel.fromJson(Map<String, dynamic> json) {
    return SellerRegisterProductModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      isActive: json['is_active'] == 1, // chuyển đổi từ 0/1 sang bool
      quantity: json['quantity'],
      soldQuantity: json['sold_quantity'],
      originalPrice: json['original_price'].toDouble(),
      discountPrice: json['discount_price'].toDouble(),
      discountPercentage: json['discount_percentage'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'is_active': isActive ? 1 : 0, // chuyển đổi từ bool sang 0/1
      'quantity': quantity,
      'sold_quantity': soldQuantity,
      'original_price': originalPrice,
      'discount_price': discountPrice,
      'discount_percentage': discountPercentage,
      'description': description,
    };
  }
}

class ProductPostModel {
  final int? industryId;
  final int? categoryId;
  final String name;
  final String description;
  final List<String> images; // Chuyển thành List<String> để lưu đường dẫn
  final String? video;

  const ProductPostModel({
    this.industryId,
    this.categoryId,
    required this.name,
    required this.description,
    required this.images,
    this.video,
  });

  Map<String, dynamic> toJson() {
    return {
      'industry_id': industryId,
      'category_id': categoryId,
      'name': name,
      'description': description,
      'images': images, // Chuyển `images` thành đường dẫn chuỗi
      'video': video,
    };
  }

  ProductPostModel copyWith({
    int? industryId,
    int? categoryId,
    String? name,
    String? description,
    List<String>? images, // Dùng List<String> thay vì MultipartFile
    String? video,
  }) {
    return ProductPostModel(
      industryId: industryId ?? this.industryId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      video: video ?? this.video,
    );
  }

  factory ProductPostModel.fromJson(Map<String, dynamic> json) {
    return ProductPostModel(
      industryId: json['industry_id'],
      categoryId: json['category_id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(
          json['images'] ?? []), // Lưu ý chuyển thành List<String>
      video: json['video'],
    );
  }
}
