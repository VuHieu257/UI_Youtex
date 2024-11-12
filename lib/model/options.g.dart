// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Options _$OptionsFromJson(Map<String, dynamic> json) => Options(
      (json['id'] as num).toInt(),
      (json['sizeId'] as num).toInt(),
      (json['colorId'] as num).toInt(),
      (json['quantity'] as num).toInt(),
      json['originalPrice'] as String,
      json['discount_price'] as String? ?? 'Không xác định',
      json['discount_percentage'] as String? ?? 'Không xác định',
    );

Map<String, dynamic> _$OptionsToJson(Options instance) => <String, dynamic>{
      'id': instance.id,
      'sizeId': instance.sizeId,
      'colorId': instance.colorId,
      'quantity': instance.quantity,
      'originalPrice': instance.originalPrice,
      'discount_price': instance.discountPrice,
      'discount_percentage': instance.discountPercentage,
    };
