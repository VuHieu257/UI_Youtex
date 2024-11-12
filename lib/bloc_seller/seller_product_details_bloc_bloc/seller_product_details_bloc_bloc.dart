import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ui_youtex/bloc_seller/seller_product_details_bloc_bloc/seller_product_details_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_details_bloc_bloc/seller_product_details_bloc_bloc.dart';
import 'package:ui_youtex/model/product.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/token_manager.dart';

import 'seller_product_details_bloc_bloc.dart';

part 'seller_product_details_bloc_event.dart';
part 'seller_product_details_bloc_state.dart';

// BLoC
class ProductDetailsBloc extends Bloc<ProductEvent, ProductState> {
  final RestfulApiProviderImpl restfulApiProvider;

  ProductDetailsBloc({required this.restfulApiProvider})
      : super(ProductInitial()) {
    on<FetchProductDetail>(_onFetchProductDetail);
  }
  Future<void> _onFetchProductDetail(
    FetchProductDetail event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final token = await TokenManager.getToken();
      if (token == null) {
        emit(ProductError("Token không hợp lệ"));
        return;
      }

      final response = await restfulApiProvider.postProductDetail(
        token: token,
        product_id: event.productdetails.productId.toString(),
        brand: event.productdetails.brand,
        gender: event.productdetails.gender,
        origin: event.productdetails.origin,
        material: event.productdetails.material,
        occasion: event.productdetails.occasion,
        manufacturer: event.productdetails.manufacturer,
        manufacturer_address: event.productdetails.manufacturerAddress,
      );

      // Kiểm tra định dạng của response và lấy message
      final successMessage = response is Map && response.containsKey('message')
          ? response['message']
          : 'Cập nhật thông tin thành công';
      emit(ProductSuccess(successMessage));
    } catch (e, errors) {
      // Log chi tiết lỗi
      print('Error: $e');
      print('Stack trace: $errors ');
      emit(ProductError(e.toString()));
    }
  }
}
