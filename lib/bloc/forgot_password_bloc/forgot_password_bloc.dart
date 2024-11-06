import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {

  ForgotPasswordBloc() : super(ForgotPasswordInitial()){
    on<SendForgotPasswordEmail>(_onSendEmailButtonPressed);
  }
}
RestfulApiProviderImpl restfulApiProviderImpl=RestfulApiProviderImpl();
Future<void> _onSendEmailButtonPressed(
ForgotPasswordEvent  event,
Emitter<ForgotPasswordState> emit,
    ) async {
   emit(ForgotPasswordLoading());

  try {
    if (event is SendForgotPasswordEmail) {
      final response = await restfulApiProviderImpl.forgotPassword(
          email: event.email);
      if (response.statusCode == 200) {
        emit(ForgotPasswordSuccess(messageSuccess:response.data["message"] ));
      } else {
        emit(ForgotPasswordFailure(error: 'Failed to send email'));
      }
    }
  }on DioException catch (e) {
    final errors = e.response?.data['errors'];
    final emailError = errors['email']?[0];

    emit(ForgotPasswordFailure(
      emailError: emailError,
      error:  'Failed to send email'
    ));
    emit(ForgotPasswordInitial());
  } catch (error) {
    emit( ForgotPasswordFailure(error: 'Failed to send email'));
  }
}