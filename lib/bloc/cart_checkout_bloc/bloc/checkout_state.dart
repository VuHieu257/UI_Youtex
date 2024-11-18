import 'package:ui_youtex/model/checkout.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final CheckoutResponse checkoutResponse;

  CheckoutLoaded(this.checkoutResponse);
}

class CheckoutError extends CheckoutState {
  final String message;
  final int? errorCode;

  CheckoutError(this.message, {this.errorCode});
}
