import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_Shiping_bloc_bloc/seller_product_extra_bloc_state.dart';
import 'package:ui_youtex/bloc_seller/seller_product_extra_bloc_bloc/seller_product_extra_bloc_state.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/token_manager.dart';

import 'seller_product_extra_bloc_event.dart';

class SellerProductShipingBloc
    extends Bloc<SellerProductShipingEvent, SellerProductShipingState> {
  final RestfulApiProviderImpl restfulApiProvider;

  SellerProductShipingBloc({required this.restfulApiProvider})
      : super(SellerProductShipingInitial()) {
    on<UpdateSellerProductShipingEvent>(_onUpdateSellerProductShiping);
  }
  Future<void> _onUpdateSellerProductShiping(
    UpdateSellerProductShipingEvent event,
    Emitter<SellerProductShipingState> emit,
  ) async {
    try {
      emit(SellerProductShipingLoading());

      final token = await TokenManager.getToken();
      if (token == null) {
        emit(SellerProductShipingError(
            error: 'Lỗi xác thực: Token không hợp lệ.'));
        return;
      }

      await restfulApiProvider.postProductShipping(
        token: token,
        product_id: event.productId,
        weight: event.weight!,
        dimension: event.dimension,
      );

      emit(const SellerProductShipingSuccess(
        message: 'Cập nhật thông tin Shiping sản phẩm thành công',
      ));
    } catch (e) {
      // Tùy chỉnh xử lý lỗi
      emit(SellerProductShipingError(
          error: 'Lỗi cập nhật sản phẩm: ${e.toString()}'));
    }
  }
}
