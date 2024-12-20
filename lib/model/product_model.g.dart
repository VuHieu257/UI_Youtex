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
      originalPrice: json['original_price'] as String? ?? '0',
      discountPrice: json['discount_price'] as String? ?? '0',
      discountPercentage: json['discount_percentage'] as String? ?? '0',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      soldQuantity: (json['sold_quantity'] as num?)?.toInt() ?? 0,
      minOrder: (json['min_order'] as num?)?.toInt() ?? 1,
      maxOrder: (json['max_order'] as num?)?.toInt() ?? 100,
      sizeChart: json['size_chart'] as String? ?? '',
      isOption: (json['is_option'] as num?)?.toInt() ?? 0,
      isWholesales: (json['is_wholesales'] as num?)?.toInt() ?? 0,
      isPreOrder: (json['is_pre_order'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'Unknown',
      sku: json['sku'] as String? ?? 'N/A',
      store: StoreProductDetail.fromJson(json['store'] as Map<String, dynamic>),
      sizes: (json['sizes'] as List<dynamic>?)
              ?.map((e) => Sizes.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      colors: (json['colors'] as List<dynamic>?)
              ?.map((e) => ColorsProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => Options.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'images': instance.images,
      'video': instance.video,
      'name': instance.name,
      'description': instance.description,
      'original_price': instance.originalPrice,
      'discount_price': instance.discountPrice,
      'discount_percentage': instance.discountPercentage,
      'quantity': instance.quantity,
      'sold_quantity': instance.soldQuantity,
      'min_order': instance.minOrder,
      'max_order': instance.maxOrder,
      'size_chart': instance.sizeChart,
      'is_option': instance.isOption,
      'is_wholesales': instance.isWholesales,
      'is_pre_order': instance.isPreOrder,
      'status': instance.status,
      'sku': instance.sku,
      'store': instance.store,
      'sizes': instance.sizes,
      'colors': instance.colors,
      'options': instance.options,
    };
