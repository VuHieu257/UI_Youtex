import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_youtex/util/token_manager.dart';

import '../../services/restful_api_provider.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LogoutButtonPressed>(_onLogoutEvent);
  }

  final RestfulApiProviderImpl _restfulApiProviderImpl =
      RestfulApiProviderImpl();

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

      TokenManager.saveToken(token);

      emit(AuthState(token: token, isAuthenticated: true));
      emit(LoginSuccess(token));
    } on DioException catch (e) {
      final errors = e.response?.data['errors'];
      final emailError = errors['email']?[0];
      final passwordError = errors['password']?[0];

      emit(LoginFailure(
        emailError: emailError,
        passwordError: passwordError,
      ));
      emit(LoginInitial());
    } catch (error) {
      emit(LoginFailure(
        generalError: 'Đăng nhập thất bại. Vui lòng thử lại sau.',
      ));
      emit(LoginInitial());
    }
  }

  Future<void> _onLogoutEvent(
    LogoutButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LogoutLoading());

    try {
      final token = await TokenManager.getToken();
      // final token= "17|6mZSRx4JSkxRzddL3ikaUhi39xZkaw0GMa5j7mbBd708c81b";
      final response = await _restfulApiProviderImpl.logout(token: "$token");
      if (response.statusCode == 200) {
        TokenManager.deleteToken();
        emit(LogoutSuccess());
      }
    } catch (error) {
      emit(LogoutFailure(
        error: 'Đăng nhập thất bại. Vui lòng thử lại sau.',
      ));
      emit(LogoutInitial());
    }
  }
}
