import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/token_manager.dart';

part 'bloc_seller_event_address_bloc.dart';
part 'bloc_seller_state_address_bloc.dart';

class SellerAddressBloc extends Bloc<SellerAddressEvent, SellerAddressState> {
  final RestfulApiProviderImpl restfulApiProvider;

  SellerAddressBloc({required this.restfulApiProvider})
      : super(SellerAddressInitial()) {
    // Handle GET Address
    on<FetchAddressEvent>((event, emit) async {
      emit(SellerAddressLoading());
      try {
        final token = await TokenManager.getToken();

        final response = await restfulApiProvider.getAddress(token: token!);
        emit(SellerAddressGetSuccess(response.data));
      } catch (e) {
        emit(SellerAddressError(e.toString()));
      }
    });

    // Handle POST Address
    on<SubmitAddressEvent>((event, emit) async {
      emit(SellerAddressLoading());
      try {
        final token = await TokenManager.getToken();

        final response = await restfulApiProvider.postAddress(
          label: event.label,
          token: token!,
          name: event.name,
          phone: event.phone,
          country: event.country,
          province: event.province,
          ward: event.ward,
          address: event.address,
          longitude: event.longitude,
          latitude: event.latitude,
          isDefault: event.isDefault,
        );

        emit(SellerAddressPostSuccess(response: response));
      } catch (e) {
        emit(SellerAddressError(e.toString()));
      }
    });
  }
}
