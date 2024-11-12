part of 'seller_register_bank_account_bloc_bloc.dart';

@immutable
sealed class SellerRegisterBankAccountBlocState {}

class SellerRegisterBankAccountInitial
    extends SellerRegisterBankAccountBlocState {}

class SellerRegisterBankAccountLoading
    extends SellerRegisterBankAccountBlocState {}

class SellerRegisterBankAccountLoaded
    extends SellerRegisterBankAccountBlocState {
  final BankAccountResponse bankAccountInfo;

  SellerRegisterBankAccountLoaded(this.bankAccountInfo);
}

class SellerRegisterBankAccountRegisterSuccess
    extends SellerRegisterBankAccountBlocState {
  final String message;

  SellerRegisterBankAccountRegisterSuccess(this.message);
}

class SellerRegisterBankAccountFailure
    extends SellerRegisterBankAccountBlocState {
  final String error;

  SellerRegisterBankAccountFailure({required this.error});
}
