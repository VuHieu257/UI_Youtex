import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:meta/meta.dart';

import '../../services/restful_api_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }
  final RestfulApiProviderImpl _restfulApiProviderImpl=RestfulApiProviderImpl();

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());

    try {
      final response = await _restfulApiProviderImpl.login(
        userName: event.email,
        password: event.password,
      );

      final token = response.data['access_token'];
      emit(LoginSuccess(token));
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }
}
