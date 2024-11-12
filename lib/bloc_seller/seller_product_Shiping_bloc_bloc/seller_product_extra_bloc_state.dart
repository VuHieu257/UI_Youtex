abstract class SellerProductShipingState {
  const SellerProductShipingState();
}

class SellerProductShipingInitial extends SellerProductShipingState {}

class SellerProductShipingLoading extends SellerProductShipingState {}

class SellerProductShipingSuccess extends SellerProductShipingState {
  final String message;

  const SellerProductShipingSuccess({required this.message});
}

class SellerProductShipingError extends SellerProductShipingState {
  final String error;

  const SellerProductShipingError({required this.error});
}
