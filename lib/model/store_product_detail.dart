import 'package:json_annotation/json_annotation.dart';

part 'store_product_detail.g.dart';

@JsonSerializable()
class StoreProductDetail {
  final String uuid;
  final String name;
  final String image;

  StoreProductDetail({
    required this.uuid,
    required this.name,
    required this.image,
  });

  factory StoreProductDetail.fromJson(Map<String, dynamic> json) => _$StoreProductDetailFromJson(json);

  Map<String, dynamic> toJson() => _$StoreProductDetailToJson(this);
}

