part of 'user_profile_bloc.dart';

abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  // final Map<String,dynamic> user;
  final Profile user;
  UserProfileLoaded(this.user);
}
class UserProfileError extends UserProfileState {
  final String message;
  UserProfileError(this.message);
}