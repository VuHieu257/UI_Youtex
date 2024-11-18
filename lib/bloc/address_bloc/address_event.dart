part of 'address_bloc.dart';

@immutable
abstract class AddressEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAddresses extends AddressEvent {}

class AddAddress extends AddressEvent {
  final Address address;

  AddAddress(this.address);
}

class UpdateAddress extends AddressEvent {
  final String label;
  final String name;
  final String phone;
  final String country;
  final String province;
  final String ward;
  final String address;
  final String longitude;
  final String latitude;
  final bool isDefault;

  UpdateAddress({
    required this.label,
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

class DeleteAddress extends AddressEvent {
  final int id;

  DeleteAddress(this.id);
}
