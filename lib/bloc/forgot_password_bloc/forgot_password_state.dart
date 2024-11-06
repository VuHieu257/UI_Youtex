part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String messageSuccess;
  ForgotPasswordSuccess({required this.messageSuccess});
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String? error;
  final String? emailError;

  ForgotPasswordFailure({this.error,this.emailError});
}
