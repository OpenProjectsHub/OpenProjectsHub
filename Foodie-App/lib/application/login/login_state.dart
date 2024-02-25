import 'package:freezed_annotation/freezed_annotation.dart';

import '../../infrastructure/models/response/languages_response.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    @Default(false) bool showPassword,
    @Default(false) bool isKeepLogin,
    @Default(false) bool isProfileDetailsLoading,
    @Default(false) bool isLoginError,
    @Default(false) bool isEmailNotValid,
    @Default(false) bool isPasswordNotValid,
    @Default(true) bool isSelectLanguage,
    @Default([]) List<LanguageData> list,
    @Default('') String email,
    @Default('') String password,
  }) = _LoginState;

  const LoginState._();
}