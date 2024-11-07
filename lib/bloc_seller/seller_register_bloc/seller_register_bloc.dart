import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_youtex/bloc_seller/seller_register_bloc/seller_register_event.dart';
import '../../core/model/store.info.dart';
import '../../services/restful_api_provider.dart';

part 'seller_register_state.dart';

class SellerRegisterBloc
    extends Bloc<SellerRegisterEvent, SellerRegisterState> {
  final RestfulApiProviderImpl restfulApiProvider;

  SellerRegisterBloc({required this.restfulApiProvider})
      : super(SellerRegisterInitial()) {
    on<LoadStoreInfo>(_onLoadStoreInfo); // Xử lý LoadStoreInfo
    on<SellerRegisterButtonPressed>(_onRegisterSeller);
  }
  Future<void> _onLoadStoreInfo(
      LoadStoreInfo event, Emitter<SellerRegisterState> emit) async {
    emit(SellerRegisterLoading());

    try {
      final storeInfo = await restfulApiProvider.getStoreInfo();
      emit(SellerRegisterLoaded(
          storeInfo)); // Phát ra SellerRegisterLoaded với StoreInfo
    } catch (error) {
      emit(SellerRegisterFailure(error: error.toString()));
    }
  }

  // Hàm xử lý cho event SellerRegisterButtonPressed
  Future<void> _onRegisterSeller(SellerRegisterButtonPressed event,
      Emitter<SellerRegisterState> emit) async {
    emit(SellerRegisterLoading());

    try {
      final response = await restfulApiProvider.registerStore(
        name: event.name,
        imagePath: event.imagePath,
        phone: event.phone,
        email: event.email,
      );

      if (response.statusCode == 201) {
        emit(SellerRegisterSuccess());
        // Tải lại thông tin cửa hàng sau khi đăng ký thành công
        add(const LoadStoreInfo()); // Sử dụng add() để phát sự kiện LoadStoreInfo
      } else {
        emit(SellerRegisterFailure(error: 'Đăng ký cửa hàng thất bại'));
      }
    } catch (error) {
      emit(SellerRegisterFailure(error: error.toString()));
    }
  }
}
