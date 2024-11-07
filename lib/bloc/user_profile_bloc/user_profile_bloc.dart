import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/user_profile.dart';
import '../../services/restful_api_provider.dart';
import '../../util/token_manager.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {

  UserProfileBloc() : super(UserProfileInitial()) {
    on<UserProfileEvent>((event, emit) async {
      final RestfulApiProviderImpl restfulApiProviderImpl=RestfulApiProviderImpl();
        emit(UserProfileLoading());
        try {
          // Lấy token từ TokenManager
          final token = await TokenManager.getToken();
          // const token = "16|vOMse9plbdJ1xD3d3ZPIWoIZ1fYAT3cUgEmyoc3He546ddd4";

          if (token != null) {
            // Gọi API lấy hồ sơ với token
            final response = await restfulApiProviderImpl.profile(token: token);
            final user =Profile.fromJson(response.data['user']);
            emit(UserProfileLoaded(user));
          } else {
            emit(UserProfileError('Không tìm thấy token, vui lòng đăng nhập lại.'));
          }
        } catch (error) {
          emit(UserProfileError('Lấy thông tin hồ sơ thất bại: $error'));
        }
      }
    );
  }
}
