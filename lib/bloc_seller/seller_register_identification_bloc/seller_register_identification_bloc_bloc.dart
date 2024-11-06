import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';

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
        final response = await restfulApiProvider.getidentification();
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

  // Hàm xử lý sự kiện `post`
  Future<void> _onPostIdentification(
    SellerRegisterIdentificationPostEvent event,
    Emitter<SellerRegisterIdentificationBlocState> emit,
  ) async {
    emit(SellerRegisterIdentificationLoading());
    try {
      final success =
          await restfulApiProvider.postIdentification(event.identification);
      if (success) {
        emit(SellerRegisterIdentificationLoaded(event.identification));
      } else {
        emit(SellerRegisterIdentificationError(
            'Failed to update identification information'));
      }
    } catch (e) {
      emit(SellerRegisterIdentificationError(e.toString()));
    }
  }
}
