import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/token_manager.dart';

part 'seller_register_identification_bloc_event.dart';
part 'seller_register_identification_bloc_state.dart';

class SellerRegisterIdentificationBlocBloc extends Bloc<
    SellerRegisterIdentificationBlocEvent,
    SellerRegisterIdentificationBlocState> {
  final RestfulApiProviderImpl restfulApiProvider;

  SellerRegisterIdentificationBlocBloc({required this.restfulApiProvider})
      : super(SellerRegisterIdentificationBlocInitial()) {
    on<SellerRegisterIdentificationGetEvent>(_onGetIdentification);
    on<SellerRegisterIdentificationPostEvent>(_onPostIdentification);
  }

  // Hàm xử lý sự kiện `get`
  Future<void> _onGetIdentification(
    SellerRegisterIdentificationGetEvent event,
    Emitter<SellerRegisterIdentificationBlocState> emit,
  ) async {
    emit(SellerRegisterIdentificationLoading());
    try {
      if (event.identification != null) {
        emit(SellerRegisterIdentificationLoaded(event.identification!));
      } else {
        final token = await TokenManager.getToken();

        final response =
            await restfulApiProvider.getidentification(token: token!);
        if (response.statusCode == 200) {
          final identification =
              SellerIdentificationModel.fromJson(response.data);
          emit(SellerRegisterIdentificationLoaded(identification));
        } else {
          emit(SellerRegisterIdentificationCreatePrompt(
              'No identification information found. Please create identification information.'));
        }
      }
    } catch (e) {
      emit(SellerRegisterIdentificationError(e.toString()));
    }
  }

  Future<void> _onPostIdentification(
    SellerRegisterIdentificationPostEvent event,
    Emitter<SellerRegisterIdentificationBlocState> emit,
  ) async {
    emit(SellerRegisterIdentificationLoading());
    try {
      final token = await TokenManager.getToken();

      final success = await restfulApiProvider.postIdentification(
        event.identification,
        token: token!,
      );

      if (success) {
        emit(SellerRegisterIdentificationLoaded(event.identification));
      }
    } catch (e) {
      // Truyền thông báo lỗi từ API vào trạng thái
      emit(SellerRegisterIdentificationError(e.toString()));
    }
  }
}
