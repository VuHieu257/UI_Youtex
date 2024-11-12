import 'package:json_annotation/json_annotation.dart';
import 'package:ui_youtex/model/product.dart';
import 'package:ui_youtex/model/sizes.dart';
import 'package:ui_youtex/model/store_product_detail.dart';
import 'package:ui_youtex/util/constants.dart';

import 'colors.dart';
import 'options.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String uuid;
  final List<String> images;
  @JsonKey(name: 'video', defaultValue: "Chưa có video", nullable: true)
  final String video; // Không cần nullable nếu có giá trị mặc định
  final String name;
  final String description;
  final String originalPrice;
  final String discountPrice;
  final String discountPercentage;
  final int quantity;
  final int soldQuantity;
  final int minOrder;
  final int maxOrder;
  final String sizeChart;
  final int isOption;
  final int isWholesales;
  final int isPreOrder;
  final String status;
  final String sku;
  final StoreProductDetail store;
  @JsonKey(defaultValue: [])
  final List<Sizes> sizes;
  @JsonKey(defaultValue: [])
  final List<Colors> colors;
  @JsonKey(defaultValue: [])
  final List<Options> options;

  ProductModel({
    required this.uuid,
    required this.images,
    required this.video, // Chắc chắn rằng video không phải null
    required this.name,
    required this.description,
    required this.originalPrice,
    required this.discountPrice,
    required this.discountPercentage,
    required this.quantity,
    required this.soldQuantity,
    required this.minOrder,
    required this.maxOrder,
    required this.sizeChart,
    required this.isOption,
    required this.isWholesales,
    required this.isPreOrder,
    required this.status,
    required this.sku,
    required this.store,
    required this.sizes,
    required this.colors,
    required this.options,
  });

  List<String> get fullImageUrls {
    if (images.isEmpty) return [];
    return images.map((image) {
      if (!image.startsWith('http')) {
        final cleanImagePath =
            image.startsWith('images/') ? image : 'images/$image';
        return 'http://52.77.246.91/storage/$cleanImagePath';
      }
      return image;
    }).toList();
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      uuid: json['uuid'] as String,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [], // Nếu images là null, trả về danh sách rỗng
      video:
          json['video'] as String? ?? "Chưa có video", // Trường hợp video null
      name: json['name'] as String,
      description: json['description'] as String,
      originalPrice: json['original_price'] as String,
      discountPrice: json['discount_price'] as String,
      discountPercentage: json['discount_percentage'] as String,
      quantity: (json['quantity'] as num).toInt(),
      soldQuantity: (json['sold_quantity'] as num).toInt(),
      minOrder: (json['min_order'] as num).toInt(),
      maxOrder: (json['max_order'] as num).toInt(),
      sizeChart: json['size_chart'] as String,
      isOption: (json['is_option'] as num).toInt(),
      isWholesales: (json['is_wholesales'] as num).toInt(),
      isPreOrder: (json['is_pre_order'] as num).toInt(),
      status: json['status'] as String,
      sku: json['sku'] as String,
      store: StoreProductDetail.fromJson(json['store'] as Map<String, dynamic>),
      sizes: (json['sizes'] as List<dynamic>?)
              ?.map((e) => Sizes.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [], // Nếu sizes là null, trả về danh sách rỗng
      colors: (json['colors'] as List<dynamic>?)
              ?.map((e) => Colors.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [], // Nếu colors là null, trả về danh sách rỗng
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => Options.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [], // Nếu options là null, trả về danh sách rỗng
    );
  }
}
