import 'package:json_annotation/json_annotation.dart';

part 'options.g.dart';

@JsonSerializable()
class Options {
  final int id;
  final int sizeId;
  final int colorId;
  final int quantity;
  final String originalPrice;
  @JsonKey(
      name: 'discount_price', defaultValue: "Không xác định", nullable: true)
  final String? discountPrice;
  @JsonKey(
      name: 'discount_percentage',
      defaultValue: "Không xác định",
      nullable: true)
  final String? discountPercentage;

  Options(
    this.id,
    this.sizeId,
    this.colorId,
    this.quantity,
    this.originalPrice,
    this.discountPrice,
    this.discountPercentage,
  );

  factory Options.fromJson(Map<String, dynamic> json) =>
      _$OptionsFromJson(json);

  Map<String, dynamic> toJson() => _$OptionsToJson(this);
}
