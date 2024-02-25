import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class CheckStatusDialog extends StatelessWidget {
  final VoidCallback cancel;
  final VoidCallback onTap;

  const CheckStatusDialog(
      {super.key,
      required this.cancel,
      required this.onTap,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60.w),
      decoration: BoxDecoration(
        color: Style.white.withOpacity(0.96),
        boxShadow: [
          BoxShadow(
            color: Style.white.withOpacity(0.65),
            spreadRadius: 0,
            blurRadius: 60,
            offset: const Offset(0, 20), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          15.verticalSpace,
          Text(
            AppHelpers.getTranslation(TrKeys.groupOrderProgress),
            style: Style.interNormal(
              size: 14,
              color: Style.black,
            ),
            textAlign: TextAlign.center,
          ),
          36.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  title: AppHelpers.getTranslation(TrKeys.cancel),
                  onPressed: cancel,
                  background: Style.transparent,
                  textColor: Style.black,
                  borderColor: Style.borderColor,
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: CustomButton(
                  title: AppHelpers.getTranslation(TrKeys.continueText),
                  onPressed: onTap,
                  background: Style.red,
                  textColor: Style.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
