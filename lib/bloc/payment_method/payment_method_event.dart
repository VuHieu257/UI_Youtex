part of 'payment_method_bloc.dart';


abstract class PaymentMethodEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllPaymentMethods extends PaymentMethodEvent {}

class AddPaymentMethod extends PaymentMethodEvent {
  final Map<String, dynamic> paymentMethodData;

  AddPaymentMethod(this.paymentMethodData);

  @override
  List<Object> get props => [paymentMethodData];
}

class DeletePaymentMethod extends PaymentMethodEvent {
  final String id;

  DeletePaymentMethod(this.id);

  @override
  List<Object> get props => [id];
}
