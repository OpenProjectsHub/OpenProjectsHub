import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';

import '../../../../infrastructure/services/app_helpers.dart';
import '../../../../infrastructure/services/tr_keys.dart';
import '../../../theme/app_style.dart';

class BranchItem extends StatelessWidget {
  final ShopData? shop;

  const BranchItem({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 8,
                color: Style.textGrey.withOpacity(0.2)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
              url: shop?.backgroundImg ?? "",
              height: 156.h,
              width: double.infinity,
              radius: 10),
          16.verticalSpace,
          Text(
            shop?.translation?.title ?? '',
            style: Style.interNoSemi(size: 20),
          ),
          16.verticalSpace,
          Text(
            shop?.translation?.description ?? '',
            style: Style.interNoSemi(size: 14, color: Style.textGrey),
          ),
          18.verticalSpace,
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Style.borderColor)),
            child: Row(
              children: [
                const Icon(FlutterRemix.time_line),
                6.horizontalSpace,
                Text("${AppHelpers.getTranslation(TrKeys.workingTime)}: "),
                Text(
                  "${shop?.shopWorkingDays?.firstWhere((element) {
                    return element.day?.toLowerCase() ==
                        DateFormat("EEEE").format(DateTime.now()).toLowerCase();
                  }).from} — ${shop?.shopWorkingDays?.firstWhere((element) {
                    return element.day?.toLowerCase() ==
                        DateFormat("EEEE").format(DateTime.now()).toLowerCase();
                  }).to}",
                  style: Style.interNoSemi(size: 16),
                )
              ],
            ),
          ),
          18.verticalSpace,
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Style.borderColor)),
            child: Row(
              children: [
                const Icon(FlutterRemix.phone_line),
                6.horizontalSpace,
                Text("${AppHelpers.getTranslation(TrKeys.phoneNumber)}: "),
                Text(
                  (shop?.phone == "null"
                      ? AppHelpers.getTranslation(TrKeys.noPhone)
                      : shop?.phone ??
                          AppHelpers.getTranslation(TrKeys.noPhone)),
                  style: Style.interNoSemi(size: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
