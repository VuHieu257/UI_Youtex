import 'package:json_annotation/json_annotation.dart';

part 'colors.g.dart';
@JsonSerializable()
class Colors {
  final int id;
  final String name;
  final String hexCode;

  Colors({
    required this.id,
    required this.name,
    required this.hexCode,
  });

  factory Colors.fromJson(Map<String, dynamic> json) => _$ColorsFromJson(json);

  Map<String, dynamic> toJson() => _$ColorsToJson(this);
}