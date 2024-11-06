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

  final RestfulApiProviderImpl _restfulApiProviderImpl = RestfulApiProviderImpl();

  Future<void> _onFetchAddresses(
      FetchAddresses event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      final token = await TokenManager.getToken();
      final addresses =
          await _restfulApiProviderImpl.fetchAddresses(token: "$token");
      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError("Bạn Chưa có địa chỉ nào"));
    }
  }

  Future<void> _onAddAddress(
      AddAddress event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      // event.address
      final token = await TokenManager.getToken();

      await _restfulApiProviderImpl.addAddresses(
          token: "$token",
          name: event.address.name,
          phone: event.address.phone,
          country: event.address.country,
          province: event.address.province,
          ward: event.address.ward,
          address: event.address.address,
          isDefault: event.address.isDefault);
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
          name: event.name,
          phone: event.phone,
          country: event.country,
          province: event.province,
          ward: event.ward,
          address: event.address,
          isDefault: event.isDefault);
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
