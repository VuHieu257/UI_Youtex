// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      uuid: json['uuid'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      video: json['video'] as String? ?? 'Chưa có video',
      name: json['name'] as String,
      description: json['description'] as String,
      originalPrice: json['originalPrice'] as String,
      discountPrice: json['discountPrice'] as String,
      discountPercentage: json['discountPercentage'] as String,
      quantity: (json['quantity'] as num).toInt(),
      soldQuantity: (json['soldQuantity'] as num).toInt(),
      minOrder: (json['minOrder'] as num).toInt(),
      maxOrder: (json['maxOrder'] as num).toInt(),
      sizeChart: json['sizeChart'] as String,
      isOption: (json['isOption'] as num).toInt(),
      isWholesales: (json['isWholesales'] as num).toInt(),
      isPreOrder: (json['isPreOrder'] as num).toInt(),
      status: json['status'] as String,
      sku: json['sku'] as String,
      store: StoreProductDetail.fromJson(json['store'] as Map<String, dynamic>),
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => Sizes.fromJson(e as Map<String, dynamic>))
          .toList(),
      colors: (json['colors'] as List<dynamic>)
          .map((e) => ColorsProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      options: (json['options'] as List<dynamic>)
          .map((e) => Options.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'images': instance.images,
      'video': instance.video,
      'name': instance.name,
      'description': instance.description,
      'originalPrice': instance.originalPrice,
      'discountPrice': instance.discountPrice,
      'discountPercentage': instance.discountPercentage,
      'quantity': instance.quantity,
      'soldQuantity': instance.soldQuantity,
      'minOrder': instance.minOrder,
      'maxOrder': instance.maxOrder,
      'sizeChart': instance.sizeChart,
      'isOption': instance.isOption,
      'isWholesales': instance.isWholesales,
      'isPreOrder': instance.isPreOrder,
      'status': instance.status,
      'sku': instance.sku,
      'store': instance.store,
      'sizes': instance.sizes,
      'colors': instance.colors,
      'options': instance.options,
    };
