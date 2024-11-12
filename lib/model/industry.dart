class Industry {
  final String uid;
  final String image;
  final String name;

  Industry({
    required this.uid,
    required this.image, 
    required this.name,
  });

  factory Industry.fromJson(Map<String, dynamic> json) {
    return Industry(
      uid: json['uid'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
