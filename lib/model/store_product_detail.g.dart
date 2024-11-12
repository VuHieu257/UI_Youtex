// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreProductDetail _$StoreProductDetailFromJson(Map<String, dynamic> json) =>
    StoreProductDetail(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$StoreProductDetailToJson(StoreProductDetail instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'image': instance.image,
    };
