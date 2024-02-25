
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';

import '../../../theme/app_style.dart';

class AllHoursScreen extends StatelessWidget {
  final List<ShopWorkingDay>? shopWorkingDays;

  const AllHoursScreen({super.key, required this.shopWorkingDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Style.bgGrey.withOpacity(0.96),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
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
            24.verticalSpace,
            TitleAndIcon(
              title: AppHelpers.getTranslation(TrKeys.hours),
              paddingHorizontalSize: 0,
              titleSize: 18,
            ),
            24.verticalSpace,
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.r, right: 24.r),
                itemCount: shopWorkingDays?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.r),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${shopWorkingDays?[index].day}".toUpperCase(),
                          style: Style.interNoSemi(size: 14),
                        ),
                        2.verticalSpace,
                        Text(
                            "${shopWorkingDays?[index].from} - ${shopWorkingDays?[index].to}"),
                      ],
                    ),
                  );
                }),
            32.verticalSpace,
          ],
        ),
      ),
    );
  }
}
