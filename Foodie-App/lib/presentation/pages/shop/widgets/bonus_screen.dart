import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/models/data/bonus_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';

import '../../../../infrastructure/services/local_storage.dart';
import '../../../../infrastructure/services/tr_keys.dart';
import '../../../components/buttons/custom_button.dart';
import '../../../components/title_icon.dart';
import '../../../theme/app_style.dart';
import 'package:intl/intl.dart' as intl;

class BonusScreen extends StatelessWidget {
  final BonusModel? bonus;

  const BonusScreen({super.key, required this.bonus});

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.instance.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            color: Style.bgGrey.withOpacity(0.96),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            )),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.verticalSpace,
              Center(
                child: Container(
                  height: 4.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                      color: Style.dragElement,
                      borderRadius: BorderRadius.all(Radius.circular(40.r))),
                ),
              ),
              14.verticalSpace,
              TitleAndIcon(
                title: AppHelpers.getTranslation(TrKeys.bonus),
                paddingHorizontalSize: 0,
              ),
              10.verticalSpace,
              Text(
                bonus != null
                    ? ((bonus?.type ?? "sum") == "sum")
                    ?  "${bonus?.bonusStock?.product?.translation?.title ?? ""} ${AppHelpers.getTranslation(TrKeys.giftBuy)} ${intl.NumberFormat.currency(
                  symbol: LocalStorage.instance
                      .getSelectedCurrency()
                      .symbol,
                ).format(bonus?.value ?? 0)}"
                    : "${bonus?.bonusStock?.product?.translation?.title ?? ""} ${AppHelpers.getTranslation(TrKeys.giftBuy)} ${bonus?.value ?? 0} ${AppHelpers.getTranslation(TrKeys.count)} "
                    : AppHelpers.getTranslation(TrKeys.bonus),
                style: Style.interRegular(
                  size: 14,
                  color: Style.black,
                ),
              ),
              30.verticalSpace,
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: CustomButton(
                  title: AppHelpers.getTranslation(TrKeys.wantIt),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
