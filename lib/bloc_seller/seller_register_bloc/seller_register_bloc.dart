import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ui_youtex/bloc_seller/seller_register_bloc/seller_register_event.dart';
import '../../core/model/store.info.dart';
import '../../services/restful_api_provider.dart';
import '../../util/token_manager.dart';

part 'seller_register_state.dart';

class SellerRegisterBloc
    extends Bloc<SellerRegisterEvent, SellerRegisterState> {
  final RestfulApiProviderImpl restfulApiProvider;

  SellerRegisterBloc({required this.restfulApiProvider})
      : super(SellerRegisterInitial()) {
    on<LoadStoreInfo>(_onLoadStoreInfo);
    on<SellerRegisterButtonPressed>(_onRegisterSeller);
  }
  Future<void> _onLoadStoreInfo(
      LoadStoreInfo event, Emitter<SellerRegisterState> emit) async {
    emit(SellerRegisterLoading());

    try {
      final token = await TokenManager.getToken();

      final storeInfo = await restfulApiProvider.getStoreInfo(token: token!);
      emit(SellerRegisterLoaded(storeInfo));
    } catch (error) {
      emit(SellerRegisterFailure(error: error.toString()));
    }
  }

  Future<void> _onRegisterSeller(SellerRegisterButtonPressed event,
      Emitter<SellerRegisterState> emit) async {
    emit(SellerRegisterLoading());

    try {
      final token = await TokenManager.getToken();

      final response = await restfulApiProvider.registerStore(
        token: token!,
        name: event.name,
        imagePath: event.imagePath,
        phone: event.phone,
        email: event.email,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(SellerRegisterSuccess());
        add(const LoadStoreInfo());
      } else if (response.statusCode == 403) {
         final message = response.data['message'] ?? 'Lỗi không xác định';
        emit(SellerRegisterFailure(error: message));
      } else {
        emit(SellerRegisterFailure(error: 'Đăng ký cửa hàng thất bại'));
      }
    } catch (error) {
      if (error is DioError) {
        // Lấy thông báo lỗi từ phản hồi Dio
        final message =
            error.response?.data['message'] ?? 'Lỗi không xác định từ server';
        emit(SellerRegisterFailure(error: message));
      } else {
        emit(SellerRegisterFailure(error: error.toString()));
      }
    }
  }
}
