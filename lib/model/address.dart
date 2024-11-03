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
  @JsonKey(name: 'is_default')
  final int isDefault;

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.country,
    required this.province,
    required this.ward,
    required this.address,
    required this.isDefault,
  });

  // These methods will be generated automatically
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
