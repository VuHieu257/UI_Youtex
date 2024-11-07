part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

class UpdateProfile extends EditProfileEvent {
  final String name;
  final String gender;
  final String birthday;
  final String imagePath;

  UpdateProfile({
    required this.name,
    required this.gender,
    required this.birthday,
    required this.imagePath,
  });
}
