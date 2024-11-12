import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/cart.dart';
import '../../model/cart_sponse.dart';
import '../../services/restful_api_provider.dart';
import '../../util/token_manager.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCartEvent>(_onAddToCart);
    on<FetchCartEvent>(_onGetCart);
  }
}

final RestfulApiProviderImpl restfulApiProvider = RestfulApiProviderImpl();

Future<void> _onAddToCart(
  AddToCartEvent event,
  Emitter<CartState> emit,
) async {
  try {
    emit(CartLoading());
    final token = await TokenManager.getToken();

    if (token == null) {
      emit(CartError(message: 'Token not found'));
      return;
    }
    await restfulApiProvider.addCart(
        token: token,
        uuid: event.uuid,
        quantity: event.quantity,
        colorId: event.colorId,
        sizeId: event.sizeId);

    emit(CartSuccess());
  } catch (error) {
    emit(CartError(message: error.toString()));
  }
}
Future<void> _onGetCart(
    FetchCartEvent event,
    Emitter<CartState> emit,
    ) async {
  try {
    emit(CartLoading());
    final token = await TokenManager.getToken();

    if (token == null) {
      emit(CartError(message: 'Token not found'));
      return;
    }

    final cart = await restfulApiProvider.getCart(token: token);

    emit(GetCartSuccess(carts: cart));
  } catch (error) {
    print('Error: $error');
    emit(CartError(message: error.toString()));
  }
}
