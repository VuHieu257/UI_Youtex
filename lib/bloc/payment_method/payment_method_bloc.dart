import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ui_youtex/bloc/payment_method/payment_method_state.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/token_manager.dart';

part 'payment_method_event.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc() : super(PaymentMethodInitial()) {
    on<GetAllPaymentMethods>(_onGetAllPaymentMethods);
    // on<AddPaymentMethod>(_onAddPaymentMethod);
    // on<DeletePaymentMethod>(_onDeletePaymentMethod);
  }
}

RestfulApiProviderImpl restfulApiProviderImpl = RestfulApiProviderImpl();

Future<void> _onGetAllPaymentMethods(
    GetAllPaymentMethods event, Emitter<PaymentMethodState> emit) async {
  emit(PaymentMethodLoading());
  try {
    final token = await TokenManager.getToken();
    final paymentMethods =
        await restfulApiProviderImpl.getAllPaymentMethods(token: "$token");
    emit(PaymentMethodLoaded(paymentMethods as List<Map<String, dynamic>>));
  } catch (e) {
    emit(PaymentMethodError(e.toString()));
  }
}

// Future<void> _onAddPaymentMethod(
//     AddPaymentMethod event, Emitter<PaymentMethodState> emit) async {
//   emit(PaymentMethodLoading());
//   try {
//     final token = await TokenManager.getToken();
//
//     await restfulApiProviderImpl.addBankAccount(event.paymentMethodData, token: token);
//     add(GetAllPaymentMethods()); // Refresh list
//   } catch (e) {
//     emit(PaymentMethodError(e.toString()));
//   }
// }
//
// Future<void> _onDeletePaymentMethod(
//     DeletePaymentMethod event, Emitter<PaymentMethodState> emit) async {
//   emit(PaymentMethodLoading());
//   try {
//     await paymentMethodService.deletePaymentMethod(event.id);
//     add(GetAllPaymentMethods()); // Refresh list
//   } catch (e) {
//     emit(PaymentMethodError(e.toString()));
//   }
// }
