part of 'seller_register_tax_get_bloc_bloc.dart';

@immutable
abstract class SellerRegisterTaxBlocState {}

class SellerRegisterTaxInitial extends SellerRegisterTaxBlocState {}

class SellerRegisterTaxLoading extends SellerRegisterTaxBlocState {}

class SellerRegisterTaxLoaded extends SellerRegisterTaxBlocState {
  final SellerRegisterTaxModel tax;

  SellerRegisterTaxLoaded(this.tax);
}

class SellerRegisterTaxError extends SellerRegisterTaxBlocState {
  final String message;

  SellerRegisterTaxError(this.message);
}

class SellerRegisterTaxCreatePrompt extends SellerRegisterTaxBlocState {
  final String message;

  SellerRegisterTaxCreatePrompt(this.message);
}
