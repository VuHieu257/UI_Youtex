import 'package:json_annotation/json_annotation.dart';
import 'package:ui_youtex/model/product.dart';
import 'package:ui_youtex/model/sizes.dart';
import 'package:ui_youtex/model/store_product_detail.dart';

import 'colors.dart';
import 'options.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String uuid;
  final List<String> images;
  @JsonKey(name: 'video', defaultValue: "Chưa có video",nullable: true)
  final String? video;
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
  final List<Sizes> sizes;
  final List<Colors> colors;
  final List<Options> options;

  ProductModel({
    required this.uuid,
    required this.images,
    this.video,
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

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
