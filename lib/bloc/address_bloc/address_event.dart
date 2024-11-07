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
  // final Address address;
  final String name;
  final String phone;
  final String country;
  final String province;
  final String ward;
  final String address;
  final int isDefault;

  UpdateAddress(this.address, this.name, this.phone, this.country,
      this.province, this.ward, this.isDefault);
}

class DeleteAddress extends AddressEvent {
  final int id;

  DeleteAddress(this.id);
}
