part of 'user_profile_bloc.dart';

@immutable
abstract class UserProfileEvent {}

class FetchProfileEvent extends UserProfileEvent {}