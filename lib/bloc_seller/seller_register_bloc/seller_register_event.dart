import 'package:meta/meta.dart';

// Events
@immutable
abstract class SellerRegisterEvent {
  const SellerRegisterEvent();
}

class SellerRegisterButtonPressed extends SellerRegisterEvent {
  final String name;
  final String imagePath;
  final String phone;
  final String email;

  const SellerRegisterButtonPressed({
    required this.name,
    required this.imagePath,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image_path': imagePath,
      'phone': phone,
      'email': email,
    };
  }

  // Create instance from API response
  factory SellerRegisterButtonPressed.fromJson(Map<String, dynamic> json) {
    return SellerRegisterButtonPressed(
      name: json['name'] ?? '',
      imagePath: json['image_path'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }

  // Copy with method for updates
  SellerRegisterButtonPressed copyWith({
    String? name,
    String? imagePath,
    String? phone,
    String? email,
  }) {
    return SellerRegisterButtonPressed(
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }
}

class LoadStoreInfo extends SellerRegisterEvent {
  const LoadStoreInfo();
}
