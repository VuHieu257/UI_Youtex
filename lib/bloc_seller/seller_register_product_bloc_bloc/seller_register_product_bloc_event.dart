part of 'seller_register_product_bloc_bloc.dart';

@immutable
sealed class SellerRegisterProductBlocEvent {}

class SellerRegisterProductGetEvent extends SellerRegisterProductBlocEvent {}

class SellerRegisterProductPostEvent extends SellerRegisterProductBlocEvent {
  final ProductPostModel model;

  SellerRegisterProductPostEvent({required this.model});
}

class SellerRegisterProductActivateEvent
    extends SellerRegisterProductBlocEvent {
  final String uuid;
  SellerRegisterProductActivateEvent(this.uuid);
}

class SellerRegisterProductDeleteEvent extends SellerRegisterProductBlocEvent {
  final String uuid;

  SellerRegisterProductDeleteEvent(this.uuid);
}

class SellerRegisterProductModel {
  final String id;
  final String image;
  final String name;
  final bool status;
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
    required this.status,
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
      id: json['uuid'],
      image: json['image'],
      name: json['name'],
      status: json['status'] == 'active',
      quantity: int.tryParse(json['quantity'].toString()) ??
          0, // Chuyển đổi số nguyên
      soldQuantity: int.tryParse(json['sold_quantity'].toString()) ?? 0,
      originalPrice: double.tryParse(json['original_price'].toString()) ?? 0.0,
      discountPrice: double.tryParse(json['discount_price'].toString()) ?? 0.0,
      discountPercentage:
          int.tryParse(json['discount_percentage'].toString()) ?? 0,
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': id,
      'image': image,
      'name': name,
      // Chuyển đổi `isActive` thành `status`
      'status': status ? 'active' : 'unverified',
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
