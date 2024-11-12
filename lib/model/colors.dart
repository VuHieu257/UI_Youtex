import 'package:json_annotation/json_annotation.dart';

part 'colors.g.dart';
@JsonSerializable()
class ColorsProduct {
  final int id;
  final String name;
  final String hexCode;

  ColorsProduct({
    required this.id,
    required this.name,
    required this.hexCode,
  });

  factory ColorsProduct.fromJson(Map<String, dynamic> json) => _$ColorsProductFromJson(json);

  Map<String, dynamic> toJson() => _$ColorsProductToJson(this);
}