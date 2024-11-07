part of 'seller_register_bank_account_bloc_bloc.dart';

@immutable
sealed class SellerRegisterBankAccountBlocEvent {}

class LoadSellerRegisterBankAccountInfo
    extends SellerRegisterBankAccountBlocEvent {}

class SellerRegisterBankAccountButtonPressed
    extends SellerRegisterBankAccountBlocEvent {
  // Trong SellerRegisterBankAccountButtonPressed

  final String bank;
  final String branch;
  final String number;
  final String cardHolder;
  final bool isDefault;

  SellerRegisterBankAccountButtonPressed({
    required this.bank,
    required this.branch,
    required this.number,
    required this.cardHolder,
    required this.isDefault,
  });
  Map<String, dynamic> toJson() {
    return {
      'bankName': bank,
      'branch': branch,
      'accountNumber': number,
      'cardHolder': cardHolder,
      'isDefault': isDefault,
    };
  }
}
