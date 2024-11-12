abstract class SellerProductExtraState {
  const SellerProductExtraState();
}

class SellerProductExtraInitial extends SellerProductExtraState {}

class SellerProductExtraLoading extends SellerProductExtraState {}

class SellerProductExtraSuccess extends SellerProductExtraState {
  final String message;

  const SellerProductExtraSuccess({required this.message});
}

class SellerProductExtraError extends SellerProductExtraState {
  final String error;

  const SellerProductExtraError({required this.error});
}
