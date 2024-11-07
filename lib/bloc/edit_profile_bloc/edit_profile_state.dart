part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final String message;
  EditProfileSuccess(this.message);
}

class EditProfileFailure extends EditProfileState {
  final String? error;
  final String? birthday;
  final String? gender;
  final String? name;
  EditProfileFailure( {this.error,this.birthday, this.gender,this.name});
}
