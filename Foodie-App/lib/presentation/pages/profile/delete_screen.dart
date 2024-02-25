// ignore_for_file: unused_result

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/application/shop_order/shop_order_provider.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';

import '../../../application/profile/profile_provider.dart';

class DeleteScreen extends StatelessWidget {
  final bool isDeleteAccount;

  const DeleteScreen({super.key, this.isDeleteAccount = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppHelpers.getTranslation(TrKeys.areYouSure),
          style: Style.interSemi(size: 16.sp),
          textAlign: TextAlign.center,
        ),
        isDeleteAccount
            ? Column(
                children: [
                  16.verticalSpace,
                  Consumer(builder: (context, ref, child) {
                    return CustomButton(
                        background: Style.red,
                        textColor: Style.white,
                        title: AppHelpers.getTranslation(TrKeys.deleteAccount),
                        onPressed: () {
                          ref.refresh(shopOrderProvider);
                          ref.refresh(profileProvider);
                          ref
                              .read(profileProvider.notifier)
                              .deleteAccount(context);
                        });
                  }),
                ],
              )
            : Column(
                children: [
                  24.verticalSpace,
                  Consumer(builder: (context, ref, child) {
                    return CustomButton(
                        title: AppHelpers.getTranslation(TrKeys.logout),
                        onPressed: () {
                          ref.read(profileProvider.notifier).logOut();
                          ref.refresh(shopOrderProvider);
                          ref.refresh(profileProvider);
                          context.router.popUntilRoot();
                          context.replaceRoute(const LoginRoute());
                        });
                  }),
                ],
              ),
        16.verticalSpace,
        CustomButton(
            borderColor: Style.black,
            background: Style.transparent,
            title: AppHelpers.getTranslation(TrKeys.cancel),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}
