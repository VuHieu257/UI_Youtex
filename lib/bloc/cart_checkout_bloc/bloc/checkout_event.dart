abstract class CheckoutEvent {}

class FetchCheckoutEvent extends CheckoutEvent {
  FetchCheckoutEvent();
}
class FetchPaymentUrl extends CheckoutEvent {
  final String addressId;
  final String paymentMethod;

  FetchPaymentUrl( this.addressId, this.paymentMethod);
  @override
  List<Object> get props => [addressId, paymentMethod,];
}