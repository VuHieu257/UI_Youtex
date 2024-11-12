import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/constants.dart';
import 'package:ui_youtex/util/token_manager.dart';

part 'seller_register_product_bloc_event.dart';
part 'seller_register_product_bloc_state.dart';

class SellerRegisterProductBloc extends Bloc<SellerRegisterProductBlocEvent,
    SellerRegisterProductBlocState> {
  final RestfulApiProviderImpl restfulApiProvider;

  SellerRegisterProductBloc({required this.restfulApiProvider})
      : super(SellerRegisterProductBlocInitial()) {
    on<SellerRegisterProductGetEvent>(_onGetProduct);
    on<SellerRegisterProductPostEvent>(_onPostProduct);
    on<SellerRegisterProductActivateEvent>(_onActivateProduct);
  }

  Future<void> _onGetProduct(
    SellerRegisterProductGetEvent event,
    Emitter<SellerRegisterProductBlocState> emit,
  ) async {
    try {
      emit(SellerRegisterProductLoading());
      final token = await TokenManager.getToken();

      final products = await restfulApiProvider.getProduct(token: token!);

      if (products != null && products.isNotEmpty) {
        emit(SellerRegisterProductLoaded(products));
      } else {
        emit(SellerRegisterProductCreatePrompt(
            'Không tìm thấy sản phẩm nào. Vui lòng tạo thông tin sản phẩm.'));
      }
    } on DioException catch (dioError) {
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
      final token = await TokenManager.getToken();

      final success =
          await restfulApiProvider.postProduct(event.model, token: token!);
      if (success) {
        final updatedProducts =
            await restfulApiProvider.getProduct(token: token!);
        if (updatedProducts != null) {
          emit(SellerRegisterProductSuccess('Thêm sản phẩm thành công'));
          emit(SellerRegisterProductLoaded(updatedProducts));
        }
      } else {
        emit(SellerRegisterProductError('Không thể thêm sản phẩm'));
      }
    } on DioException catch (dioError) {
      print('Dio error: ${dioError.message}');
      emit(SellerRegisterProductError('Đã xảy ra lỗi khi kết nối với API.'));
    } catch (e, stackTrace) {
      print('Error posting product: $e');
      print(stackTrace);
      emit(SellerRegisterProductError('Đã xảy ra lỗi khi thêm sản phẩm'));
    }
  }

  Future<void> _onActivateProduct(
    SellerRegisterProductActivateEvent event,
    Emitter<SellerRegisterProductBlocState> emit,
  ) async {
    try {
      emit(SellerRegisterProductLoading());
      final token = await TokenManager.getToken();

      final success = await restfulApiProvider.activateProduct(
        token: token!,
        uuid: event.uuid,
      );

      if (success) {
        emit(SellerRegisterProductSuccess(
            'Sản phẩm đã được kích hoạt thành công!'));
        add(SellerRegisterProductGetEvent()); // Làm mới danh sách sản phẩm
      } else {
        emit(SellerRegisterProductError('Kích hoạt sản phẩm thất bại'));
      }
    } on DioException catch (dioError) {
      print('Dio error: ${dioError.message}');
      emit(SellerRegisterProductError('Đã xảy ra lỗi khi kết nối với API.'));
    } catch (e, stackTrace) {
      print('Error activating product: $e');
      print(stackTrace);
      emit(SellerRegisterProductError('Đã xảy ra lỗi khi kích hoạt sản phẩm.'));
    }
  }
}
