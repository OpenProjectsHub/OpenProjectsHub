import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/app_bars/app_bar_bottom_sheet.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/text_fields/outline_bordered_text_field.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';

import '../../../../application/reser_password/reset_password_provider.dart';
import '../../../components/keyboard_dismisser.dart';

class SetPasswordPage extends ConsumerWidget {
  const SetPasswordPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final notifier = ref.read(resetPasswordProvider.notifier);
    final state = ref.watch(resetPasswordProvider);
    final bool isLtr = LocalStorage.instance.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: AbsorbPointer(
        absorbing: state.isLoading,
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
                        AppBarBottomSheet(title: AppHelpers.getTranslation(TrKeys.resetPassword),),
                        40.verticalSpace,
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
                              size: 20.r,
                            ),
                            onPressed: () => notifier.toggleShowPassword(),
                          ),
                          onChanged: (name) => notifier.setPassword(name),
                          isError: state.isPasswordInvalid,
                          descriptionText: state.isPasswordInvalid
                              ? AppHelpers.getTranslation(TrKeys
                              .passwordShouldContainMinimum8Characters)
                              : null,
                        ),
                        34.verticalSpace,
                        OutlinedBorderTextField(
                          label: AppHelpers.getTranslation(TrKeys.password)
                              .toUpperCase(),
                          obscure: state.showConfirmPassword,
                          suffixIcon: IconButton(
                            splashRadius: 25,
                            icon: Icon(
                              state.showConfirmPassword
                                  ? FlutterRemix.eye_line
                                  : FlutterRemix.eye_close_line,
                              size: 20.r,
                            ),
                            onPressed: () =>
                                notifier.toggleShowConfirmPassword(),
                          ),
                          onChanged: (name) => notifier.setConfirmPassword(name),
                          isError: state.isConfirmPasswordInvalid,
                          descriptionText: state.isConfirmPasswordInvalid
                              ? AppHelpers.getTranslation(
                              TrKeys.confirmPasswordIsNotTheSame)
                              : null,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom,top: 120.h),
                      child: CustomButton(
                        isLoading: state.isLoading,
                        title: AppHelpers.getTranslation(TrKeys.send),
                        onPressed: () {
                          notifier.setResetPassword(context);
                        },
                        background: Style.brandGreen,
                        textColor: Style.black,
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
