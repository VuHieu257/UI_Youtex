// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Options _$OptionsFromJson(Map<String, dynamic> json) => Options(
      (json['id'] as num).toInt(),
      (json['size_id'] as num).toInt(),
      ( json['color_id'] as num).toInt(),
      ( json['quantity'] as num).toInt(),
      json['original_price'] as String,
      json['discount_price'] as String? ?? 'Không xác định',
      json['discount_percentage'] as String? ?? 'Không xác định',
    );

Map<String, dynamic> _$OptionsToJson(Options instance) => <String, dynamic>{
      'id': instance.id,
      'size_id': instance.sizeId,
      'color_id': instance.colorId,
      'original_price': instance.originalPrice,
      'discount_price': instance.discountPrice,
      'discount_percentage': instance.discountPercentage,
    };
