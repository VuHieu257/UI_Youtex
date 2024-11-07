part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent {}

class SendForgotPasswordEmail extends ForgotPasswordEvent {
  final String email;

  SendForgotPasswordEmail({required this.email});
  @override
  List<Object> get props => [email];
}
