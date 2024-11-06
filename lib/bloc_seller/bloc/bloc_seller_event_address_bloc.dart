part of 'bloc_seller_address_bloc.dart';

@immutable
 abstract class SellerAddressEvent {}

class FetchAddressEvent extends SellerAddressEvent {}

class SubmitAddressEvent extends SellerAddressEvent {
  final String name;
  final String phone;
  final String country;
  final String province;
  final String ward;
  final String address;
  final String longitude;
  final String latitude;
  final bool isDefault;

  SubmitAddressEvent({
    required this.name,
    required this.phone,
    required this.country,
    required this.province,
    required this.ward,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.isDefault,
  });
}