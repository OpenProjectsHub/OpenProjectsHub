import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool showPassword,
    @Default(false) bool showConfirmPassword,
    @Default(false) bool isEmailInvalid,
    @Default(false) bool isPasswordInvalid,
    @Default(false) bool isConfirmPasswordInvalid,
    @Default('') String phone,
    @Default('') String verificationId,
    @Default('') String email,
    @Default('') String referral,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String password,
    @Default('') String confirmPassword,
  }) = _RegisterState;

  const RegisterState._();
}