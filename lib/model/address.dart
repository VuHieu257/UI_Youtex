import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final int id;
  final String name;
  final String phone;
  final String country;
  final String province;
  final String ward;
  final String address;
  @JsonKey(name: 'is_default', fromJson: _boolFromInt)
  final bool isDefault;

  final String? label;
  final String? longitude;
  final String? latitude;

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.country,
    required this.province,
    required this.ward,
    required this.address,
    required this.isDefault,
    this.label,
    this.longitude,
    this.latitude,
  });

  // Convert integer to boolean
  static bool _boolFromInt(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) return value == '1' || value.toLowerCase() == 'true';
    return false;
  }

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
