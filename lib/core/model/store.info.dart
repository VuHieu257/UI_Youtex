class StoreInfo {
  final String name;
  final String imagePath;
  final String phone;
  final String email;

  StoreInfo({
    required this.name,
    required this.imagePath,
    required this.phone,
    required this.email,
  });

  factory StoreInfo.fromJson(Map<String, dynamic> json) {
    return StoreInfo(
      name: json['name'] ?? 'a',
      imagePath: json['image'] ?? '',
      phone: json['phone'] ?? 'a',
      email: json['email'] ?? 'a',
    );
  }

  @override
  String toString() {
    return 'StoreInfo(name: $name, imagePath: $imagePath, phone: $phone, email: $email)';
  }
}
