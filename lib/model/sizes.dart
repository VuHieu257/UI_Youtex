import 'package:json_annotation/json_annotation.dart';

part 'sizes.g.dart';

@JsonSerializable()
class Sizes {
  final int id;
  final String name;

  Sizes({
    required this.id,
    required this.name,
  });

  factory Sizes.fromJson(Map<String, dynamic> json) => _$SizesFromJson(json);

  Map<String, dynamic> toJson() => _$SizesToJson(this);
}