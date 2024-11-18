import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/bloc/cart_checkout_bloc/bloc/checkout_event.dart';
import 'package:ui_youtex/bloc/cart_checkout_bloc/bloc/checkout_state.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/token_manager.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final RestfulApiProviderImpl restfulApiProvider;

  CheckoutBloc(this.restfulApiProvider) : super(CheckoutInitial()) {
    on<FetchCheckoutEvent>(_onFetchCheckout);
    on<FetchPaymentUrl>(_onFetchPaymentUrl);
  }
  Future<void> _onFetchCheckout(
    FetchCheckoutEvent event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(CheckoutLoading());
    try {
      final token = await TokenManager.getToken();

      if (token == null) {
        emit(CheckoutError('Token is null. Please log in.'));
        return;
      }

      final response = await restfulApiProvider.fetchCheckout(token: token);
      emit(CheckoutLoaded(response));
    } catch (error) {
      emit(CheckoutError('Failed to load checkout data: $error'));
    }
  }
  Future<void> _onFetchPaymentUrl(
      FetchPaymentUrl event,
      Emitter<CheckoutState> emit,
      ) async {
    emit(PaymentLoading());
    try {
      final token = await TokenManager.getToken();

      if (token == null) {
        emit(PaymentFailure('Token is null. Please log in.'));
        return;
      }

      final response = await restfulApiProvider.payment(paymentMethod: event.paymentMethod,addressId: event.addressId,token: token);

      emit(PaymentSuccess(response));
    } catch (error) {
      emit(PaymentFailure('Failed to load checkout data: $error'));
    }
  }
}

