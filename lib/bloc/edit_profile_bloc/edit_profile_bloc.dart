import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../services/restful_api_provider.dart';
import '../../util/token_manager.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileEvent>(_onEditProfileButtonPressed);

    // on<EditProfileEvent>((event, emit) {
    //   @override
    //   Stream<EditProfileState> mapEventToState(EditProfileEvent event) async* {
    //     if (event is UpdateProfile) {
    //       yield EditProfileLoading();
    //       final RestfulApiProviderImpl restfulApiProviderImpl =
    //           RestfulApiProviderImpl();
    //       try {
    //         final token = await TokenManager.getToken();
    //         final response = await restfulApiProviderImpl.editProfile(
    //             name: event.name,
    //             gender: event.gender,
    //             birthday: event.birthday,
    //             imagePath: event.imagePath, token:"$token");
    //         if (response.statusCode == 200) {
    //           yield EditProfileSuccess("Profile updated successfully");
    //         } else {
    //           yield EditProfileFailure("Failed to update profile");
    //         }
    //       } catch (e) {
    //         yield EditProfileFailure("Error: $e");
    //       }
    //     }
    //   }
    // });
  }
  Future<void> _onEditProfileButtonPressed(
      EditProfileEvent event,
      Emitter<EditProfileState> emit,
      ) async {
    if (event is UpdateProfile) {
      emit( EditProfileLoading());
      final RestfulApiProviderImpl restfulApiProviderImpl =
      RestfulApiProviderImpl();
      try {
        final token = await TokenManager.getToken();
        final response = await restfulApiProviderImpl.editProfile(
            name: event.name,
            gender: event.gender,
            birthday: event.birthday,
            imagePath: event.imagePath, token:"$token");
        if (response.statusCode == 200) {
          emit( EditProfileSuccess("Profile updated successfully"));
        } else {
          emit(EditProfileFailure(error:"Failed to update profile"));

        }
      }on DioException catch (e) {
        final errors = e.response?.data['errors'];
        final birthdayError = errors['birthday']?[0];
        final nameError = errors['name']?[0];
        final genderError = errors['gender']?[0];

        emit(EditProfileFailure(
         birthday: birthdayError,
          gender: genderError,
          name: nameError
        ));
        emit(EditProfileInitial());
      } catch (e) {
        emit(EditProfileFailure(error:"Error: $e"));
      }
    }
  }

}
