part of 'seller_register_status_bloc.dart';

@immutable
abstract class SellerRegisterStatusState {}

class SellerRegisterStatusInitial extends SellerRegisterStatusState {}

class SellerRegisterStatusLoading extends SellerRegisterStatusState {}

class SellerRegisterStatusSuccess extends SellerRegisterStatusState {
  final dynamic data;
  
  SellerRegisterStatusSuccess(this.data);
}

class SellerRegisterStatusError extends SellerRegisterStatusState {
  final String message;
  
  SellerRegisterStatusError(this.message);
}