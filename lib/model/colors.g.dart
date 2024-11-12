// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Colors _$ColorsFromJson(Map<String, dynamic> json) => Colors(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      hexCode: json['hex_code'] as String,
    );

Map<String, dynamic> _$ColorsToJson(Colors instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hex_code': instance.hexCode,
    };
