part of 'seller_register_bank_account_bloc_bloc.dart';

@immutable
sealed class SellerRegisterBankAccountBlocEvent {}

class LoadSellerRegisterBankAccountInfo
    extends SellerRegisterBankAccountBlocEvent {}

class SellerRegisterBankAccountButtonPressed
    extends SellerRegisterBankAccountBlocEvent {
  // Trong SellerRegisterBankAccountButtonPressed
  void validateInput() {
    if (bankName.isEmpty)
      throw ArgumentError('Tên ngân hàng không được để trống');
    if (accountNumber.isEmpty)
      throw ArgumentError('Số tài khoản không được để trống');
    if (cardHolder.isEmpty)
      throw ArgumentError('Tên chủ thẻ không được để trống');
  }

  final String bankName;
  final String branch;
  final String accountNumber;
  final String cardHolder;
  final bool isDefault;

  SellerRegisterBankAccountButtonPressed({
    required this.bankName,
    required this.branch,
    required this.accountNumber,
    required this.cardHolder,
    required this.isDefault,
  });
  Map<String, dynamic> toJson() {
    return {
      'bankName': bankName,
      'branch': branch,
      
      'accountNumber': accountNumber,
      'cardHolder': cardHolder,
      'isDefault': isDefault,
    };
  }
}
