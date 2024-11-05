import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/restful_api_provider.dart';
import '../../util/token_manager.dart';

part 'fetch_user_by_phone_event.dart';

part 'fetch_user_by_phone_state.dart';

class FetchUserByPhoneBloc
    extends Bloc<FetchUserByPhoneEvent, FetchUserByPhoneState> {
  FetchUserByPhoneBloc() : super(FetchUserByPhoneInitial()) {
    on<FetchUserByPhone>(_onFetchUserByPhoneEvent);
  }

  final RestfulApiProviderImpl _restfulApiProviderImpl =
      RestfulApiProviderImpl();
  Future<void> _onFetchUserByPhoneEvent(
      FetchUserByPhone event,
      Emitter<FetchUserByPhoneState> emit,
      ) async {
    emit(UserLoading());
    try {
      final token = await TokenManager.getToken();
      final user = await _restfulApiProviderImpl.getUserByPhone(
        token: "$token",
        phone: event.phone,
      );
      emit(UserLoaded(
        id: '${user['user']['id']}',
        name: '${user['user']['name']}',
        img: user['user']['image'],
        phone: user['user']['phone'],
      ));
    } catch (e) {
      emit(UserError("Failed to load user data"));
    }
  }
}
