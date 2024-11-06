part of 'seller_register_tax_get_bloc_bloc.dart';

@immutable
sealed class SellerRegisterTaxBlocEvent {}

class SellerRegisterTaxGetBlocEvent extends SellerRegisterTaxBlocEvent {
  final SellerRegisterTaxModel? model;

  SellerRegisterTaxGetBlocEvent({this.model});
}

class SellerRegisterTaxPostBlocEvent extends SellerRegisterTaxBlocEvent {
  final SellerRegisterTaxModel model;

  SellerRegisterTaxPostBlocEvent({required this.model});
}

class SellerRegisterTaxModel {
  final String type;
  final String address;
  final String email;
  final String taxCode;
  final String name;
  final String? businessLicense;

  SellerRegisterTaxModel({
    required this.type,
    required this.address,
    required this.email,
    required this.taxCode,
    required this.name,
    required this.businessLicense,
  });

  factory SellerRegisterTaxModel.fromJson(Map<String, dynamic> json) {
    return SellerRegisterTaxModel(
      type: json['type'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      taxCode: json['tax_code'] ?? '',
      name: json['name'] ?? '',
      businessLicense: json['business_license'] ?? '',
    );
  }
  @override
  String toString() {
    return 'SellerRegisterTaxModel(type: $type, name: $name, address: $address, email: $email, taxCode: $taxCode, businessLicense: $businessLicense)';
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'address': address,
      'email': email,
      'tax_code': taxCode,
      'name': name,
      'business_license': businessLicense,
    };
  }
}
