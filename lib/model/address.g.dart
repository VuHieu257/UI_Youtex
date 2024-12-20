// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      country: json['country'] as String,
      province: json['province'] as String,
      ward: json['ward'] as String,
      address: json['address'] as String,
      isDefault: Address._boolFromInt(json['is_default']),
      label: json['label'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'country': instance.country,
      'province': instance.province,
      'ward': instance.ward,
      'address': instance.address,
      'is_default': instance.isDefault,
      'label': instance.label,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
