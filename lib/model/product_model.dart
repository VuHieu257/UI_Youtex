import 'package:json_annotation/json_annotation.dart';
import 'package:ui_youtex/model/product.dart';
import 'package:ui_youtex/model/sizes.dart';
import 'package:ui_youtex/model/store_product_detail.dart';

import 'colors.dart';
import 'options.dart';

part 'product_model.g.dart';

// @JsonSerializable()
// class ProductModel {
//   final String uuid;
//   final List<String> images;
//   @JsonKey(name: 'video', defaultValue: "Chưa có video", nullable: true)
//   final String? video;
//   final String name;
//   final String description;
//   @JsonKey(name: 'original_price')
//   final String originalPrice;
//   @JsonKey(name: 'discount_price')
//   final String discountPrice;
//   @JsonKey(name: 'discount_percentage')
//   final String discountPercentage;
//   final int quantity;
//   @JsonKey(name: 'sold_quantity')
//   final int soldQuantity;
//   @JsonKey(name: 'min_order')
//   final int minOrder;
//   @JsonKey(name: 'max_order')
//   final int maxOrder;
//   @JsonKey(name: 'size_chart')
//   final String sizeChart;
//   @JsonKey(name: 'is_option')
//   final int isOption;
//   @JsonKey(name: 'is_wholesales')
//   final int isWholesales;
//   @JsonKey(name: 'is_pre_order')
//   final int isPreOrder;
//   final String status;
//   final String sku;
//   final StoreProductDetail store;
//   final List<Sizes> sizes;
//   final List<ColorsProduct> colors;
//   @JsonKey(name: 'options', defaultValue: "", nullable: true)
//   final List<Options>? options;
//
//   ProductModel({
//     required this.uuid,
//     required this.images,
//     this.video,
//     required this.name,
//     required this.description,
//     required this.originalPrice,
//     required this.discountPrice,
//     required this.discountPercentage,
//     required this.quantity,
//     required this.soldQuantity,
//     required this.minOrder,
//     required this.maxOrder,
//     required this.sizeChart,
//     required this.isOption,
//     required this.isWholesales,
//     required this.isPreOrder,
//     required this.status,
//     required this.sku,
//     required this.store,
//     this.sizes = const [],
//     this.colors = const [],
//     List<Options>? options,
//   }) : options = isOption == 0 ? null : options;
//
//   factory ProductModel.fromJson(Map<String, dynamic> json) =>
//       _$ProductModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ProductModelToJson(this);
// }
@JsonSerializable()
class ProductModel {
  final String uuid;
  final List<String> images;

  @JsonKey(name: 'video', defaultValue: "Chưa có video")
  final String video;

  final String name;
  final String description;

  @JsonKey(name: 'original_price', defaultValue: "0")
  final String originalPrice;

  @JsonKey(name: 'discount_price', defaultValue: "0")
  final String discountPrice;

  @JsonKey(name: 'discount_percentage', defaultValue: "0")
  final String discountPercentage;

  @JsonKey(defaultValue: 0)
  final int quantity;

  @JsonKey(name: 'sold_quantity', defaultValue: 0)
  final int soldQuantity;

  @JsonKey(name: 'min_order', defaultValue: 1)
  final int minOrder;

  @JsonKey(name: 'max_order', defaultValue: 100)
  final int maxOrder;

  @JsonKey(name: 'size_chart', defaultValue: "")
  final String sizeChart;

  @JsonKey(name: 'is_option', defaultValue: 0)
  final int isOption;

  @JsonKey(name: 'is_wholesales', defaultValue: 0)
  final int isWholesales;

  @JsonKey(name: 'is_pre_order', defaultValue: 0)
  final int isPreOrder;

  @JsonKey(defaultValue: "Unknown")
  final String status;

  @JsonKey(defaultValue: "N/A")
  final String sku;

  final StoreProductDetail store;

  @JsonKey(defaultValue: [])
  final List<Sizes> sizes;

  @JsonKey(defaultValue: [])
  final List<ColorsProduct> colors;

  @JsonKey(name: 'options', defaultValue: [])
  final List<Options> options;

  ProductModel({
    required this.uuid,
    required this.images,
    required this.video,
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
    this.sizes = const [],
    this.colors = const [],
    this.options = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
