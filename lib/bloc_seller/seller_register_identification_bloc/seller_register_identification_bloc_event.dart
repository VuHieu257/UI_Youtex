// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seller_register_identification_bloc_bloc.dart';

@immutable
sealed class SellerRegisterIdentificationBlocEvent {}

class SellerRegisterIdentificationGetEvent
    extends SellerRegisterIdentificationBlocEvent {
  final SellerIdentificationModel? identification;

  SellerRegisterIdentificationGetEvent({this.identification});
}

class SellerRegisterIdentificationPostEvent
    extends SellerRegisterIdentificationBlocEvent {
  final SellerIdentificationModel identification;

  SellerRegisterIdentificationPostEvent({required this.identification});
}

class SellerIdentificationModel {
  final String type;
  final String number;
  final String name;
  final String image;
  final String selfie;

  SellerIdentificationModel({
    required this.type,
    required this.number,
    required this.name,
    required this.image,
    required this.selfie,
  });

  factory SellerIdentificationModel.fromJson(Map<String, dynamic> json) {
    return SellerIdentificationModel(
      type: json['type'] ?? '',
      number: json['number'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      selfie: json['selfie'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'number': number,
      'name': name,
      'image': image,
      'selfie': selfie,
    };
  }
}
