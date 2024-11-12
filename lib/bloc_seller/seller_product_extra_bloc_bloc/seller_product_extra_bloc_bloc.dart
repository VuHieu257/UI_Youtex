import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_extra_bloc_bloc/seller_product_extra_bloc_state.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/token_manager.dart';

import 'seller_product_extra_bloc_event.dart';

class SellerProductExtraBloc
    extends Bloc<SellerProductExtraEvent, SellerProductExtraState> {
  final RestfulApiProviderImpl restfulApiProvider;

  SellerProductExtraBloc({required this.restfulApiProvider})
      : super(SellerProductExtraInitial()) {
    on<UpdateSellerProductExtraEvent>(_onUpdateSellerProductExtra);
  }
  Future<void> _onUpdateSellerProductExtra(
    UpdateSellerProductExtraEvent event,
    Emitter<SellerProductExtraState> emit,
  ) async {
    try {
      emit(SellerProductExtraLoading());

      final token = await TokenManager.getToken();
      if (token == null) {
        emit(SellerProductExtraError(
            error: 'Lỗi xác thực: Token không hợp lệ.'));
        return;
      }

      await restfulApiProvider.postProductExtra(
        token: token,
        product_id: event.productId,
        is_pre_order: event.isPreOrder,
        status: event.status,
        sku: event.sku,
      );

      emit(const SellerProductExtraSuccess(
        message: 'Cập nhật thông tin sản phẩm thành công',
      ));
    } catch (e) {
      // Tùy chỉnh xử lý lỗi
      emit(SellerProductExtraError(
          error: 'Lỗi cập nhật sản phẩm: ${e.toString()}'));
    }
  }
}
