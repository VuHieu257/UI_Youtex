
import 'package:equatable/equatable.dart';

abstract class PaymentMethodState extends Equatable {
  @override
  List<Object> get props => [];
}

class PaymentMethodInitial extends PaymentMethodState {}

class PaymentMethodLoading extends PaymentMethodState {}

class PaymentMethodLoaded extends PaymentMethodState {
  final List<Map<String, dynamic>> paymentMethods;

  PaymentMethodLoaded(this.paymentMethods);

  @override
  List<Object> get props => [paymentMethods];
}

class PaymentMethodError extends PaymentMethodState {
  final String error;

  PaymentMethodError(this.error);

  @override
  List<Object> get props => [error];
}
