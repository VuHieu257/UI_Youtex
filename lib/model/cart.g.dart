// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      store: Store.fromJson(json['store'] as Map<String, dynamic>),
      cartItems: (json['cart_items'] as List<dynamic>?)
              ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'store': instance.store,
      'cart_items': instance.cartItems,
    };

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'image': instance.image,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      originalPrice: json['original_price'] as String,
      discountPrice: json['discount_price'] as String,
      discountPercentage: json['discount_percentage'] as String,
      size: json['size'] as String? ?? 'N/A',
      color: json['color'] as String? ?? 'N/A',
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      options: json['options'] == null
          ? null
          : Options.fromJson(json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'original_price': instance.originalPrice,
      'discount_price': instance.discountPrice,
      'discount_percentage': instance.discountPercentage,
      'size': instance.size,
      'color': instance.color,
      'images': instance.images,
      'options': instance.options,
    };

Options _$OptionsFromJson(Map<String, dynamic> json) => Options(
      sizes: (json['sizes'] as List<dynamic>?)
              ?.map((e) => SizeOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      colors: (json['colors'] as List<dynamic>?)
              ?.map((e) => ColorOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OptionsToJson(Options instance) => <String, dynamic>{
      'sizes': instance.sizes,
      'colors': instance.colors,
    };

SizeOption _$SizeOptionFromJson(Map<String, dynamic> json) => SizeOption(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$SizeOptionToJson(SizeOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ColorOption _$ColorOptionFromJson(Map<String, dynamic> json) => ColorOption(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      hexCode: json['hex_code'] as String,
    );

Map<String, dynamic> _$ColorOptionToJson(ColorOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hex_code': instance.hexCode,
    };
