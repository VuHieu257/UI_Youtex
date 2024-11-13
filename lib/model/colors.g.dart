// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorsProduct _$ColorsProductFromJson(Map<String, dynamic> json) =>
    ColorsProduct(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      hexCode: json['hex_code'] as String,
    );

Map<String, dynamic> _$ColorsProductToJson(ColorsProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hex_code': instance.hexCode,
    };
