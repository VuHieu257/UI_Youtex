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
  final String? type;
  final String? name;
  final String? address;
  final String? email;
  final String? taxCode;
  final String? businessLicense;

  SellerRegisterTaxModel({
    this.type,
    this.name,
    this.address,
    this.email,
    this.taxCode,
    this.businessLicense,
  });

  factory SellerRegisterTaxModel.fromJson(Map<String, dynamic> json) {
    // Parse from the 'tax' object in the response
    final taxData = json['tax'] as Map<String, dynamic>? ?? json;

    return SellerRegisterTaxModel(
      type: taxData['type'] as String?,
      name: taxData['name'] as String?,
      address: taxData['address'] as String?,
      email: taxData['email'] as String?,
      taxCode: taxData['tax_code'] as String?,
      businessLicense: taxData['business_license'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'address': address,
      'email': email,
      'tax_code': taxCode,
      'business_license': businessLicense,
    };
  }
}
