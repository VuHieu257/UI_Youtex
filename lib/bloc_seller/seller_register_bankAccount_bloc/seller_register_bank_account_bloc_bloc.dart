import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_youtex/core/model/bank.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/token_manager.dart';

part 'seller_register_bank_account_bloc_event.dart';
part 'seller_register_bank_account_bloc_state.dart';

class SellerRegisterBankAccountBloc extends Bloc<
    SellerRegisterBankAccountBlocEvent, SellerRegisterBankAccountBlocState> {
  final RestfulApiProviderImpl restfulApiProvider;

  SellerRegisterBankAccountBloc({required this.restfulApiProvider})
      : super(SellerRegisterBankAccountInitial()) {
    on<LoadSellerRegisterBankAccountInfo>(_onLoadBankAccountInfo);
    on<SellerRegisterBankAccountButtonPressed>(_onRegisterBankAccount);
  }
  Future<void> _onLoadBankAccountInfo(
    LoadSellerRegisterBankAccountInfo event,
    Emitter<SellerRegisterBankAccountBlocState> emit,
  ) async {
    emit(SellerRegisterBankAccountLoading());

    try {
      final token = await TokenManager.getToken();

      final bankAccountInfo =
          await restfulApiProvider.sellerpaymentmethodssGet(token: token!);
      emit(SellerRegisterBankAccountLoaded(bankAccountInfo));
    } catch (error) {
      emit(SellerRegisterBankAccountFailure(error: error.toString()));
    }
  }

  Future<void> _onRegisterBankAccount(
      SellerRegisterBankAccountButtonPressed event,
      Emitter<SellerRegisterBankAccountBlocState> emit) async {
    emit(SellerRegisterBankAccountLoading());

    try {
      final token = await TokenManager.getToken();

      final response = await restfulApiProvider.postBankAccount(token: token!,
        bank: event.bank,
        branch: event.branch,
        number: event.number,
        cardHolder: event.cardHolder,
        isDefault: event.isDefault,
      );

      if (response.statusCode == 200) {
        emit(SellerRegisterBankAccountRegisterSuccess());
        add(LoadSellerRegisterBankAccountInfo());
      } else {
        emit(SellerRegisterBankAccountFailure(
            error: 'Đăng ký tài khoản ngân hàng thất bại: ${response.data}'));
      }
    } catch (e) {
      emit(SellerRegisterBankAccountFailure(
          error: 'An error occurred: ${e.toString()}'));
    }
  }
}
