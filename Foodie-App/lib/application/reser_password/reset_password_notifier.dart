import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/iterface/auth.dart';
import 'package:shoppingapp/domain/iterface/user.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/app_validators.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';


import 'reset_password_state.dart';

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  final AuthRepositoryFacade _authRepository;
  final UserRepositoryFacade _userRepositoryFacade;

  ResetPasswordNotifier(this._authRepository, this._userRepositoryFacade)
      : super(const ResetPasswordState());

  void setEmail(String text) {
    state = state.copyWith(email: text.trim(), isEmailError: false);
  }

  void setVerifyId(String? value) {
    state = state.copyWith(verifyId: value?.trim() ?? '');
  }

  void setPassword(String password) {
    state = state.copyWith(password: password.trim(), isPasswordInvalid: false);
  }

  void setConfirmPassword(String password) {
    state = state.copyWith(
      confirmPassword: password.trim(),
      isConfirmPasswordInvalid: false,
    );
  }

  void toggleShowPassword() {
    state = state.copyWith(showPassword: !state.showPassword);
  }

  void toggleShowConfirmPassword() {
    state = state.copyWith(showConfirmPassword: !state.showConfirmPassword);
  }


  checkEmail() {
    return AppValidators.isValidEmail(state.email);
  }

  Future<void> sendCodeToNumber(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true, isSuccess: false);
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: state.email,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(
                AppHelpers.getTranslation(e.message ?? "")),
          );
          state = state.copyWith(isLoading: false, isSuccess: false);
        },
        codeSent: (String verificationId, int? resendToken) {
          state = state.copyWith(
              phone: state.email,
              isLoading: false,
              verificationId: verificationId,
            isSuccess: true,);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> sendCode(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true, isSuccess: false);
      final response =
          await _authRepository.forgotPassword(email: state.email.trim());
      response.when(
        success: (data) async {
          state = state.copyWith(
              verifyId: data.data?.verifyId ?? '',
              isLoading: false,
              isSuccess: true);
        },
        failure: (failure, status) {
          state = state.copyWith(
              isLoading: false, isEmailError: true, isSuccess: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
          debugPrint('==> send otp failure: $failure');
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showCheckTopSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      }
    }
  }

  Future<void> setResetPassword(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (!AppValidators.isValidPassword(state.password)) {
        state = state.copyWith(isPasswordInvalid: true);
        return;
      }
      if (!AppValidators.isValidConfirmPassword(
          state.password, state.confirmPassword)) {
        state = state.copyWith(isConfirmPasswordInvalid: true);
        return;
      }
      state = state.copyWith(isLoading: true, isSuccess: false);
      final response = await _userRepositoryFacade.updatePassword(
        password: state.password,
        passwordConfirmation: state.confirmPassword,
      );
      response.when(
        success: (data) async {
          state = state.copyWith(isLoading: false, isSuccess: true);
          context.replaceRoute(const MainRoute());
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false, isSuccess: false);
          if (status == 400) {
            AppHelpers.showCheckTopSnackBar(
              context,
              AppHelpers.getTranslation(
                  AppHelpers.getTranslation(TrKeys.emailAlreadyExists)),
            );
          } else {
            AppHelpers.showCheckTopSnackBar(
              context,
              AppHelpers.getTranslation(failure.toString()),
            );
          }
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }
}
