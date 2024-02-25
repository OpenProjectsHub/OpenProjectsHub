import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/app_bars/app_bar_bottom_sheet.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/buttons/forgot_text_button.dart';
import 'package:shoppingapp/presentation/components/buttons/social_button.dart';
import 'package:shoppingapp/presentation/components/keyboard_dismisser.dart';
import 'package:shoppingapp/presentation/components/text_fields/outline_bordered_text_field.dart';
import 'package:shoppingapp/presentation/pages/auth/reset/reset_password_page.dart';

import '../../../theme/app_style.dart';
import '../../../../application/login/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.read(loginProvider.notifier);
    final state = ref.watch(loginProvider);
    final bool isDarkMode = LocalStorage.instance.getAppThemeMode();
    final bool isLtr = LocalStorage.instance.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: KeyboardDismisser(
        child: Container(
          margin: MediaQuery.of(context).viewInsets,
          decoration: BoxDecoration(
              color: Style.bgGrey.withOpacity(0.96),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              )),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      AppBarBottomSheet(
                        title: AppHelpers.getTranslation(TrKeys.login),
                      ),
                      OutlinedBorderTextField(
                        label: AppHelpers.getTranslation(TrKeys.emailOrPhoneNumber)
                            .toUpperCase(),
                        onChanged: event.setEmail,
                        isError: state.isEmailNotValid,
                        descriptionText: state.isEmailNotValid
                            ? AppHelpers.getTranslation(TrKeys.emailIsNotValid)
                            : null,
                      ),
                      34.verticalSpace,
                      OutlinedBorderTextField(
                        label: AppHelpers.getTranslation(TrKeys.password)
                            .toUpperCase(),
                        obscure: state.showPassword,
                        suffixIcon: IconButton(
                          splashRadius: 25,
                          icon: Icon(
                            state.showPassword
                                ? FlutterRemix.eye_line
                                : FlutterRemix.eye_close_line,
                            color: isDarkMode ? Style.black : Style.hintColor,
                            size: 20.r,
                          ),
                          onPressed: () =>
                              event.setShowPassword(!state.showPassword),
                        ),
                        onChanged: event.setPassword,
                        isError: state.isPasswordNotValid,
                        descriptionText: state.isPasswordNotValid
                            ? AppHelpers.getTranslation(
                                TrKeys.passwordShouldContainMinimum8Characters)
                            : null,
                      ),
                      30.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: Checkbox(
                                  side: BorderSide(
                                    color: Style.black,
                                    width: 2.r,
                                  ),
                                  activeColor: Style.black,
                                  value: state.isKeepLogin,
                                  onChanged: (value) =>
                                      event.setKeepLogin(value!),
                                ),
                              ),
                              8.horizontalSpace,
                              Text(
                                AppHelpers.getTranslation(TrKeys.keepLogged),
                                style: Style.interNormal(
                                  size: 12.sp,
                                  color: Style.black,
                                ),
                              ),
                            ],
                          ),
                          ForgotTextButton(
                            title: AppHelpers.getTranslation(
                              TrKeys.forgotPassword,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              AppHelpers.showCustomModalBottomSheet(
                                context: context,
                                modal: const ResetPasswordPage(),
                                isDarkMode: isDarkMode,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomButton(
                        isLoading: state.isLoading,
                        title: 'Login',
                        onPressed: () {
                          event.login(context);
                          // context.replaceRoute(const MainRoute());
                        },
                      ),
                      32.verticalSpace,
                      Row(children: <Widget>[
                        Expanded(
                            child: Divider(
                          color: Style.black.withOpacity(0.5),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(right: 12, left: 12),
                          child: Text(
                            AppHelpers.getTranslation(TrKeys.orAccessQuickly),
                            style: Style.interNormal(
                              size: 12.sp,
                              color: Style.textGrey,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          color: Style.black.withOpacity(0.5),
                        )),
                      ]),
                      22.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SocialButton(
                              iconData: FlutterRemix.apple_fill,
                              onPressed: () {
                                event.loginWithApple(context);
                              },
                              title: "Apple"),
                          SocialButton(
                              iconData: FlutterRemix.facebook_fill,
                              onPressed: () {
                                event.loginWithFacebook(context);
                              },
                              title: "Facebook"),
                          SocialButton(
                              iconData: FlutterRemix.google_fill,
                              onPressed: () {
                                event.loginWithGoogle(context);
                              },
                              title: "Google"),
                        ],
                      ),
                      22.verticalSpace,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
