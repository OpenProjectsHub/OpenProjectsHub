// ignore_for_file: unused_result

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/application/confirmation/register_confirmation_provider.dart';
import 'package:shoppingapp/infrastructure/models/data/user.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/app_bars/app_bar_bottom_sheet.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/keyboard_dismisser.dart';
import 'package:shoppingapp/presentation/pages/auth/reset/set_password_page.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../theme/theme.dart';
import '../register/register_page.dart';

@RoutePage()
class RegisterConfirmationPage extends ConsumerStatefulWidget {
  final UserModel userModel;
  final bool isResetPassword;
  final String verificationId;

  const RegisterConfirmationPage({
    super.key,
    required this.userModel,
    this.isResetPassword = false,
    required this.verificationId,
  });

  @override
  ConsumerState<RegisterConfirmationPage> createState() =>
      _RegisterConfirmationPageState();
}

class _RegisterConfirmationPageState
    extends ConsumerState<RegisterConfirmationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(registerConfirmationProvider);
      ref.read(registerConfirmationProvider.notifier).startTimer();
    });
  }

  @override
  void deactivate() {
    ref.read(registerConfirmationProvider.notifier).disposeTimer();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(registerConfirmationProvider.notifier);
    final state = ref.watch(registerConfirmationProvider);
    final bool isDarkMode = LocalStorage.instance.getAppThemeMode();
    final bool isLtr = LocalStorage.instance.getLangLtr();
    ref.listen(registerConfirmationProvider, (previous, next) {
      if (previous!.isSuccess != next.isSuccess && next.isSuccess) {
        Navigator.pop(context);
        AppHelpers.showCustomModalBottomSheet(
          context: context,
          modal: const RegisterPage(
            isOnlyEmail: false,
          ),
          isDarkMode: isDarkMode,
        );
      }
      if (previous.isResetPasswordSuccess != next.isResetPasswordSuccess &&
          next.isResetPasswordSuccess) {
        Navigator.pop(context);
        AppHelpers.showCustomModalBottomSheet(
          context: context,
          modal: const SetPasswordPage(),
          isDarkMode: isDarkMode,
        );
      }
    });
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: AbsorbPointer(
        absorbing: state.isLoading || state.isResending,
        child: KeyboardDismisser(
          child: Container(
            padding: MediaQuery.of(context).viewInsets,
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        AppBarBottomSheet(
                          title: AppHelpers.getTranslation(TrKeys.enterOtp),
                        ),
                        Text(
                          AppHelpers.getTranslation(TrKeys.sendOtp),
                          style: Style.interRegular(
                            size: 14,
                            color: Style.black,
                          ),
                        ),
                        Text(
                          widget.userModel.email ?? "",
                          style: Style.interRegular(
                            size: 14,
                            color: Style.black,
                          ),
                        ),
                        40.verticalSpace,
                        SizedBox(
                          height: 64,
                          child: PinFieldAutoFill(
                            codeLength: 6,
                            currentCode: state.confirmCode,
                            onCodeChanged: notifier.setCode,
                            cursor: Cursor(
                              width: 1,
                              height: 24,
                              color: isDarkMode ? Style.white : Style.black,
                              enabled: true,
                            ),
                            decoration: BoxLooseDecoration(
                              gapSpace: 10.r,
                              textStyle: Style.interNormal(
                                size: 15.sp,
                                color: isDarkMode ? Style.white : Style.black,
                              ),
                              bgColorBuilder: FixedColorBuilder(
                                isDarkMode
                                    ? Style.mainBackDark
                                    : Style.transparent,
                              ),
                              strokeColorBuilder: FixedColorBuilder(
                                state.isCodeError
                                    ? Style.red
                                    : isDarkMode
                                        ? Style.borderDark
                                        : Style.outlineButtonBorder,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).padding.bottom,
                          top: 120.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            isLoading: state.isResending,
                            title: state.isTimeExpired
                                ? AppHelpers.getTranslation(TrKeys.resendOtp)
                                : state.timerText,
                            onPressed: () {
                              if (state.isTimeExpired) {
                                widget.verificationId.isEmpty
                                    ? notifier.resendConfirmation(
                                        context, widget.userModel.email ?? "",
                                        isResetPassword: widget.isResetPassword)
                                    : notifier.sendCodeToNumber(
                                        context,
                                        widget.userModel.email ?? "",
                                      );
                                notifier.startTimer();
                              }
                            },
                            weight:
                                (MediaQuery.of(context).size.width - 40) / 3,
                            background: Style.black,
                            textColor: Style.white,
                          ),
                          CustomButton(
                            isLoading: state.isLoading,
                            title:
                                AppHelpers.getTranslation(TrKeys.confirmation),
                            onPressed: () {
                              if (widget.isResetPassword) {
                                widget.verificationId.isEmpty
                                    ? notifier.confirmCodeResetPassword(
                                        context, widget.userModel.email ?? "")
                                    : notifier
                                        .confirmCodeResetPasswordWithPhone(
                                            context,
                                            widget.userModel.email ?? "");
                              } else {
                                widget.verificationId.isEmpty
                                    ? notifier.confirmCode(context)
                                    : notifier.confirmCodeWithFirebase(
                                        context: context,
                                        verificationId: widget.verificationId);
                              }
                            },
                            weight: 2 *
                                (MediaQuery.of(context).size.width - 40) /
                                3,
                            background: state.isConfirm
                                ? Style.brandGreen
                                : Style.white,
                            textColor:
                                state.isConfirm ? Style.black : Style.textGrey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
