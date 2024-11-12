part of 'bloc_seller_address_bloc.dart';

@immutable
sealed class BlocSellerState {}

abstract class SellerAddressState {}

class SellerAddressInitial extends SellerAddressState {}

class SellerAddressLoading extends SellerAddressState {}

class SellerAddressGetSuccess extends SellerAddressState {
  final dynamic data;

  SellerAddressGetSuccess(this.data);
}

class SellerAddressPostSuccess extends SellerAddressState {
  final dynamic response;

  SellerAddressPostSuccess({required this.response});
}

class SellerAddressError extends SellerAddressState {
  final String errorMessage;

  SellerAddressError(this.errorMessage);
}