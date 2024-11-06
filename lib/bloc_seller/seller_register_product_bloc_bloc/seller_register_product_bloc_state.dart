part of 'seller_register_product_bloc_bloc.dart';

@immutable
sealed class SellerRegisterProductBlocState {}

class SellerRegisterProductBlocInitial extends SellerRegisterProductBlocState {}

class SellerRegisterProductLoading extends SellerRegisterProductBlocState {}

class SellerRegisterProductLoaded extends SellerRegisterProductBlocState {
  final List<SellerRegisterProductModel> products;

  SellerRegisterProductLoaded(this.products);
}

class SellerRegisterProductCreatePrompt extends SellerRegisterProductBlocState {
  final String message;

  SellerRegisterProductCreatePrompt(this.message);
}

class SellerRegisterProductError extends SellerRegisterProductBlocState {
  final String message;

  SellerRegisterProductError(this.message);
}

class SellerRegisterProductSuccess extends SellerRegisterProductBlocState {
  final String message;

  SellerRegisterProductSuccess(this.message);
}
