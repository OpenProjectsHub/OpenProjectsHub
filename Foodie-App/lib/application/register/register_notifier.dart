import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoppingapp/domain/iterface/auth.dart';
import 'package:shoppingapp/domain/iterface/user.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/app_validators.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../infrastructure/models/data/user.dart';
import '../../infrastructure/services/local_storage.dart';
import 'register_state.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  final AuthRepositoryFacade _authRepository;
  final UserRepositoryFacade _userRepositoryFacade;

  RegisterNotifier(
    this._authRepository,
    this._userRepositoryFacade,
  ) : super(const RegisterState());

  void setPassword(String password) {
    state = state.copyWith(password: password.trim(), isPasswordInvalid: false);
  }

  void setConfirmPassword(String password) {
    state = state.copyWith(
      confirmPassword: password.trim(),
      isConfirmPasswordInvalid: false,
    );
  }

  void setFirstName(String name) {
    state = state.copyWith(firstName: name.trim());
  }

  void setEmail(String value) {
    state = state.copyWith(email: value.trim(), isEmailInvalid: false);
  }

  void setPhone(String value) {
    state = state.copyWith(
      phone: value.trim(),
    );
  }

  void setLatName(String name) {
    state = state.copyWith(lastName: name.trim());
  }

  void setReferral(String name) {
    state = state.copyWith(referral: name.trim());
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

  Future<void> sendCode(BuildContext context, VoidCallback onSuccess) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (!AppValidators.isValidEmail(state.email)) {
        state = state.copyWith(isEmailInvalid: true);
        return;
      }
      state = state.copyWith(isLoading: true, isSuccess: false);
      final response = await _authRepository.sigUp(
        email: state.email,
      );
      response.when(
        success: (data) async {
          state = state.copyWith(isLoading: false, isSuccess: true);
          onSuccess();
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

  Future<void> sendCodeToNumber(
      BuildContext context, ValueChanged<String> onSuccess) async {
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
            isSuccess: true,
          );
          onSuccess(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> register(BuildContext context) async {
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
      state = state.copyWith(isLoading: true);
      final response = await _authRepository.sigUpWithData(
          user: UserModel(
              email: state.email,
              firstname: state.firstName,
              lastname: state.lastName,
              phone: state.phone,
              password: state.password,
              confirmPassword: state.confirmPassword,
              referral: state.referral));

      response.when(
        success: (data) async {
          state = state.copyWith(
            isLoading: false,
          );
          LocalStorage.instance.setToken(data.token);
          context.replaceRoute(const MainRoute());
          String? fcmToken = await FirebaseMessaging.instance.getToken();
          _userRepositoryFacade.updateFirebaseToken(fcmToken);
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false);
          if (status == 400) {
            AppHelpers.showCheckTopSnackBar(
              context,
              AppHelpers.getTranslation(
                  AppHelpers.getTranslation(TrKeys.referralIncorrect)),
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

  Future<void> registerWithPhone(BuildContext context) async {
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
      state = state.copyWith(isLoading: true);
      final response = await _authRepository.sigUpWithPhone(
          user: UserModel(
              email: state.email,
              firstname: state.firstName,
              lastname: state.lastName,
              phone: state.phone,
              password: state.password,
              confirmPassword: state.confirmPassword,
              referral: state.referral));

      response.when(
        success: (data) async {
          state = state.copyWith(
            isLoading: false,
          );
          LocalStorage.instance.setToken(data.token);
          context.replaceRoute(const MainRoute());
          String? fcmToken = await FirebaseMessaging.instance.getToken();
          _userRepositoryFacade.updateFirebaseToken(fcmToken);
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false);
          if (status == 400) {
            AppHelpers.showCheckTopSnackBar(
              context,
              AppHelpers.getTranslation(
                  AppHelpers.getTranslation(TrKeys.referralIncorrect)),
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

  Future<void> loginWithGoogle(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      GoogleSignInAccount? googleUser;
      try {
        googleUser = await GoogleSignIn().signIn();
      } catch (e) {
        state = state.copyWith(isLoading: false);
        debugPrint('===> login with google exception: $e');
        if (mounted) {
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(e.toString()),
          );
        }
      }
      if (googleUser == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      final response = await _authRepository.loginWithGoogle(
        email: googleUser.email,
        displayName: googleUser.displayName ?? '',
        id: googleUser.id,
        avatar: googleUser.photoUrl ?? "",
      );
      response.when(
        success: (data) async {
          state = state.copyWith(isLoading: false);
          LocalStorage.instance.setToken(data.data?.accessToken ?? '');
          context.router.popUntilRoot();
          context.replaceRoute(const MainRoute());
          String? fcmToken = await FirebaseMessaging.instance.getToken();
          _userRepositoryFacade.updateFirebaseToken(fcmToken);
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> loginWithFacebook(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final fb = FacebookLogin();
      debugPrint('===> login with face exceptio');
      try {
        final user = await fb.logIn(permissions: [
          FacebookPermission.email,
        ]);

        final OAuthCredential credential =
            FacebookAuthProvider.credential(user.accessToken?.token ?? "");

        final userObj =
            await FirebaseAuth.instance.signInWithCredential(credential);

        debugPrint(
            '===> login with face exception: ${user.accessToken?.declinedPermissions}');
        if (user.status == FacebookLoginStatus.success) {
          final response = await _authRepository.loginWithGoogle(
            email: userObj.user?.email ?? "",
            displayName: userObj.user?.displayName ?? "",
            id: userObj.user?.uid ?? "",
            avatar: userObj.user?.photoURL ?? "",
          );
          response.when(
            success: (data) async {
              state = state.copyWith(isLoading: false);
              LocalStorage.instance.setToken(data.data?.accessToken ?? '');
              context.router.popUntilRoot();
              context.replaceRoute(const MainRoute());
              String? fcmToken = await FirebaseMessaging.instance.getToken();
              _userRepositoryFacade.updateFirebaseToken(fcmToken);
            },
            failure: (failure, status) {
              state = state.copyWith(isLoading: false);
              AppHelpers.showCheckTopSnackBar(
                context,
                AppHelpers.getTranslation(failure.toString()),
              );
            },
          );
        } else {
          state = state.copyWith(isLoading: false);
          // ignore: use_build_context_synchronously
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(TrKeys.somethingWentWrongWithTheServer),
          );
        }
      } catch (e) {
        state = state.copyWith(isLoading: false);
        debugPrint('===> login with face exception: $e');
        if (mounted) {
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(e.toString()),
          );
        }
      }
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> loginWithApple(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);

      try {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        OAuthProvider oAuthProvider = OAuthProvider("apple.com");
        final AuthCredential credentialApple = oAuthProvider.credential(
          idToken: credential.identityToken,
          accessToken: credential.authorizationCode,
        );

        final userObj =
            await FirebaseAuth.instance.signInWithCredential(credentialApple);

        final response = await _authRepository.loginWithGoogle(
            email: credential.email ?? userObj.user?.email ?? "",
            displayName:
                credential.givenName ?? userObj.user?.displayName ?? "",
            id: credential.userIdentifier ?? userObj.user?.uid ?? "",
            avatar: userObj.user?.displayName ?? "");
        response.when(
          success: (data) async {
            state = state.copyWith(isLoading: false);
            LocalStorage.instance.setToken(data.data?.accessToken ?? '');
            context.router.popUntilRoot();
            context.replaceRoute(const MainRoute());
            String? fcmToken = await FirebaseMessaging.instance.getToken();
            _userRepositoryFacade.updateFirebaseToken(fcmToken);
          },
          failure: (failure, s) {
            state = state.copyWith(isLoading: false);
            AppHelpers.showCheckTopSnackBar(
              context,
              AppHelpers.getTranslation(s.toString()),
            );
          },
        );
      } catch (e) {
        state = state.copyWith(isLoading: false);
        debugPrint('===> login with apple exception: $e');
        if (mounted) {
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(e.toString()),
          );
        }
      }
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }
}
