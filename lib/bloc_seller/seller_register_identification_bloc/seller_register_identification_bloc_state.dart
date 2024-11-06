part of 'seller_register_identification_bloc_bloc.dart';

@immutable
abstract class SellerRegisterIdentificationBlocState {}

class SellerRegisterIdentificationBlocInitial
    extends SellerRegisterIdentificationBlocState {}

class SellerRegisterIdentificationLoading
    extends SellerRegisterIdentificationBlocState {}

class SellerRegisterIdentificationLoaded
    extends SellerRegisterIdentificationBlocState {
  final SellerIdentificationModel identification;

  SellerRegisterIdentificationLoaded(this.identification);
}

class SellerRegisterIdentificationCreatePrompt
    extends SellerRegisterIdentificationBlocState {
  final String message;

  SellerRegisterIdentificationCreatePrompt(this.message);
}

class SellerRegisterIdentificationError
    extends SellerRegisterIdentificationBlocState {
  final String error;

  SellerRegisterIdentificationError(this.error);
}
