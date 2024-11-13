import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  final Store store;
  @JsonKey(name: 'cart_items')
  final List<CartItem> cartItems;

  Cart({required this.store, required this.cartItems});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable()
class Store {
  final String uuid;
  final String name;
  final String image;

  Store({required this.uuid, required this.name, required this.image});

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}

@JsonSerializable()
class CartItem {
  final int id;
  final String name;
  final int quantity;
  @JsonKey(name: 'original_price')
  final String originalPrice;
  @JsonKey(name: 'discount_price')
  final String discountPrice;
  @JsonKey(name: 'discount_percentage')
  final String discountPercentage;
  final String? size;
  final String? color;
  final List<String> images;
  final Options? options;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.originalPrice,
    required this.discountPrice,
    required this.discountPercentage,
    this.size,
    this.color,
    required this.images,
    this.options,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

@JsonSerializable()
class Options {
  @JsonKey(fromJson: _parseSizes)
  final List<SizeOption> sizes;
  @JsonKey(fromJson: _parseColors)
  final List<ColorOption> colors;

  Options({required this.sizes, required this.colors});

  factory Options.fromJson(Map<String, dynamic> json) => _$OptionsFromJson(json);
  Map<String, dynamic> toJson() => _$OptionsToJson(this);

  // Custom parsing function for sizes
  static List<SizeOption> _parseSizes(dynamic json) {
    if (json is String) {
      return (jsonDecode(json) as List)
          .map((e) => SizeOption.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  static List<ColorOption> _parseColors(dynamic json) {
    if (json is String) {
      return (jsonDecode(json) as List)
          .map((e) => ColorOption.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}

@JsonSerializable()
class SizeOption {
  final int id;
  final String name;

  SizeOption({required this.id, required this.name});

  factory SizeOption.fromJson(Map<String, dynamic> json) => _$SizeOptionFromJson(json);
  Map<String, dynamic> toJson() => _$SizeOptionToJson(this);
}

@JsonSerializable()
class ColorOption {
  final int id;
  final String name;
  @JsonKey(name: 'hex_code')
  final String hexCode;

  ColorOption({required this.id, required this.name, required this.hexCode});

  factory ColorOption.fromJson(Map<String, dynamic> json) => _$ColorOptionFromJson(json);
  Map<String, dynamic> toJson() => _$ColorOptionToJson(this);
}
