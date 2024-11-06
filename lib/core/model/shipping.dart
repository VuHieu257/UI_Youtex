import 'dart:convert';

class ShippingUnit {
  final int id;
  final String name;
  final String description;
  final Settings settings;

  ShippingUnit({
    required this.id,
    required this.name,
    required this.description,
    required this.settings,
  });

  factory ShippingUnit.fromJson(Map<String, dynamic> json) {
    return ShippingUnit(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      settings: Settings.fromJson(json['settings']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'settings': settings.toJson(),
    };
  }
}

class Settings {
  final int isCod;
  final int isActive;

  Settings({
    required this.isCod,
    required this.isActive,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      isCod: json['is_cod'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_cod': isCod,
      'is_active': isActive,
    };
  }
}

class ShippingRequest {
  final List<ShippingUnit> shippingUnits;

  ShippingRequest({
    required this.shippingUnits,
  });

  factory ShippingRequest.fromJson(Map<String, dynamic> json) {
    var list = json['shipping_units'] as List;
    List<ShippingUnit> shippingUnits =
        list.map((i) => ShippingUnit.fromJson(i)).toList();

    return ShippingRequest(shippingUnits: shippingUnits);
  }

  Map<String, dynamic> toJson() {
    return {
      'shipping_units': shippingUnits.map((e) => e.toJson()).toList(),
    };
  }
}
