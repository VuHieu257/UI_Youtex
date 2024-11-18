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

class PaymentLoading extends CheckoutState {}

class PaymentSuccess extends CheckoutState {
  final String paymentUrl;

  PaymentSuccess(this.paymentUrl);
}

class PaymentFailure extends CheckoutState {
  final String error;

  PaymentFailure(this.error);
}
