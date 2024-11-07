import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';

part 'seller_register_status_event.dart';
part 'seller_register_status_state.dart';

class SellerRegisterStatusBloc
    extends Bloc<SellerRegisterStatusEvent, SellerRegisterStatusState> {
  final RestfulApiProviderImpl restfulApiProvider;

  SellerRegisterStatusBloc({required this.restfulApiProvider})
      : super(SellerRegisterStatusInitial()) {
    on<GetSellerStatusEvent>(_onGetSellerStatus);
  }

  Future<void> _onGetSellerStatus(
    GetSellerStatusEvent event,
    Emitter<SellerRegisterStatusState> emit,
  ) async {
    try {
      emit(SellerRegisterStatusLoading());

      final response = await restfulApiProvider.getAddress();

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SellerRegisterStatusSuccess(response.data));
      } else {
        emit(SellerRegisterStatusError('${response.statusCode}'));
      }
    } on DioException catch (e) {
      String errorMessage;

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          errorMessage = 'Kết nối tới server bị timeout. Vui lòng thử lại.';
          break;
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 401) {
            errorMessage = 'Không có quyền truy cập. Vui lòng đăng nhập lại.';
          } else if (statusCode == 404) {
            errorMessage = 'Không tìm thấy dữ liệu.';
          } else {
            errorMessage = 'Lỗi từ server: $statusCode';
          }
          break;
        case DioExceptionType.cancel:
          errorMessage = 'Yêu cầu đã bị hủy';
          break;
        default:
          errorMessage = 'Lỗi kết nối: ${e.message}';
      }

      emit(SellerRegisterStatusError(errorMessage));
    } catch (error) {
      emit(SellerRegisterStatusError(
          'Đã xảy ra lỗi không xác định: ${error.toString()}'));
    }
  }
}
