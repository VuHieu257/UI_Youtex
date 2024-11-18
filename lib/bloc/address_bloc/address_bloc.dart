import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../model/address.dart';
import '../../services/restful_api_provider.dart';
import '../../util/token_manager.dart';

part 'address_event.dart';

part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<FetchAddresses>(_onFetchAddresses);
    on<AddAddress>(_onAddAddress);
    on<UpdateAddress>(_onUpdateAddress);
    on<DeleteAddress>(_onDeleteAddress);
  }

  final RestfulApiProviderImpl _restfulApiProviderImpl =
      RestfulApiProviderImpl();

  Future<void> _onFetchAddresses(
      FetchAddresses event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      final token = await TokenManager.getToken();
      if (token == null) {
        emit(AddressError("Token không hợp lệ"));
        return;
      }

      final addresses =
          await _restfulApiProviderImpl.fetchAddresses(token: token);

      // Debug logs
      print('Bloc received addresses');
      print('Addresses count: ${addresses.length}');

      if (addresses.isEmpty) {
        emit(AddressError("Bạn chưa có địa chỉ nào"));
      } else {
        emit(AddressLoaded(addresses));
      }
    } catch (e) {
      print('Error in bloc: $e'); // Debug log
      emit(AddressError("Không thể tải địa chỉ. Vui lòng thử lại sau."));
    }
  }

  Future<void> _onAddAddress(
      AddAddress event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      final token = await TokenManager.getToken();

      await _restfulApiProviderImpl.addAddresses(
        token: "$token",
        label: event.address.label!,
        name: event.address.name,
        phone: event.address.phone,
        country: event.address.country,
        province: event.address.province,
        ward: event.address.ward,
        address: event.address.address,
        longitude: event.address.longitude!,
        latitude: event.address.latitude!,
        isDefault: event.address.isDefault,
      );
      add(FetchAddresses()); // Re-fetch addresses after adding
    } catch (e) {
      emit(AddressError("Bạn chưa có địa chỉ nào"));
    }
  }

  Future<void> _onUpdateAddress(
      UpdateAddress event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      final token = await TokenManager.getToken();

      await _restfulApiProviderImpl.addAddresses(
        token: "$token",
        label: event.label,
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
      add(FetchAddresses());
    } catch (e) {
      emit(AddressError("Failed to update address"));
    }
  }

  Future<void> _onDeleteAddress(
      DeleteAddress event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      final token = await TokenManager.getToken();

      await _restfulApiProviderImpl.deleteAddresses(
          id: "${event.id}", token: "$token");
      add(FetchAddresses()); // Re-fetch addresses after deleting
    } catch (e) {
      emit(AddressError("Failed to delete address"));
    }
  }
}
