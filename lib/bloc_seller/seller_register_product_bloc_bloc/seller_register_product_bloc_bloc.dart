import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/constants.dart';

part 'seller_register_product_bloc_event.dart';
part 'seller_register_product_bloc_state.dart';

class SellerRegisterProductBloc extends Bloc<SellerRegisterProductBlocEvent,
    SellerRegisterProductBlocState> {
  final RestfulApiProviderImpl restfulApiProvider;

  SellerRegisterProductBloc({required this.restfulApiProvider})
      : super(SellerRegisterProductBlocInitial()) {
    on<SellerRegisterProductGetEvent>(_onGetProduct);
    on<SellerRegisterProductPostEvent>(_onPostProduct);
  }

 Future<void> _onGetProduct(
  SellerRegisterProductGetEvent event,
  Emitter<SellerRegisterProductBlocState> emit,
) async {
  try {
    emit(SellerRegisterProductLoading());

    final products = await restfulApiProvider.getProduct();

    if (products != null && products.isNotEmpty) {
      emit(SellerRegisterProductLoaded(products));
    } else {
      emit(SellerRegisterProductCreatePrompt(
          'Không tìm thấy sản phẩm nào. Vui lòng tạo thông tin sản phẩm.'));
    }
  } on DioError catch (dioError) {
    // Xử lý lỗi cụ thể của Dio
    print('Dio error: ${dioError.message}');
    emit(SellerRegisterProductError('Đã xảy ra lỗi khi kết nối với API.'));
  } catch (e, stackTrace) {
    print('Error getting products: $e');
    print(stackTrace);
    emit(SellerRegisterProductError('Đã xảy ra lỗi khi lấy sản phẩm.'));
  }
}

  Future<void> _onPostProduct(
    SellerRegisterProductPostEvent event,
    Emitter<SellerRegisterProductBlocState> emit,
  ) async {
    try {
      emit(SellerRegisterProductLoading());

      final success = await restfulApiProvider.postProduct(event.model);
      if (success) {
        final updatedProducts = await restfulApiProvider.getProduct();
        if (updatedProducts != null) {
          emit(SellerRegisterProductSuccess('Thêm sản phẩm thành công'));
          emit(SellerRegisterProductLoaded(updatedProducts));
        }
      } else {
        emit(SellerRegisterProductError('Không thể thêm sản phẩm'));
      }
    } on DioError catch (dioError) {
      print('Dio error: ${dioError.message}');
      emit(SellerRegisterProductError('Đã xảy ra lỗi khi kết nối với API.'));
    } catch (e, stackTrace) {
      print('Error posting product: $e');
      print(stackTrace);
      emit(SellerRegisterProductError('Đã xảy ra lỗi khi thêm sản phẩm'));
    }
  }
}
