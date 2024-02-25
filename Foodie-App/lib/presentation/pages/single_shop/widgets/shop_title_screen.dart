import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/animation_button_effect.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../theme/app_style.dart';
import 'all_hours_screen.dart';

class ShopTitleScreen extends StatelessWidget {
  final TimeOfDay endTodayTime;
  final TimeOfDay startTodayTime;
  final ShopData? shop;

  const ShopTitleScreen(
      {super.key,
      required this.endTodayTime,
      required this.startTodayTime,
      required this.shop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    endTodayTime.hour > TimeOfDay.now().hour
                        ? AppHelpers.getTranslation(TrKeys.workingNow)
                        : AppHelpers.getTranslation(TrKeys.closedNow),
                    style: Style.interSemi(size: 14, color: Style.red),
                  ),
                  6.horizontalSpace,
                  Container(
                    width: 4.r,
                    height: 4.r,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Style.textGrey),
                  ),
                  6.horizontalSpace,
                  Text(
                    "${startTodayTime.hour.toString().padLeft(2, '0')}:${startTodayTime.minute.toString().padLeft(2, '0')} - ${endTodayTime.hour.toString().padLeft(2, '0')}:${endTodayTime.minute.toString().padLeft(2, '0')}",
                    style: Style.interNormal(size: 14, color: Style.textGrey),
                  ),
                ],
              ),
              8.verticalSpace,
              AnimationButtonEffect(
                child: InkWell(
                  onTap: () {
                    AppHelpers.showCustomModalBottomSheet(
                        context: context,
                        modal: AllHoursScreen(
                          shopWorkingDays: shop?.shopWorkingDays,
                        ),
                        isDarkMode: false);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4.r),
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.seeAllHour),
                      style: Style.interNoSemi(size: 15, color: Style.blue),
                    ),
                  ),
                ),
              )
            ],
          ),
          const Spacer(),
          Column(
            children: [
              InkWell(
                onTap: () async {
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: shop?.phone ?? "",
                  );
                  await launchUrl(launchUri);
                },
                child: AnimationButtonEffect(
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Style.switchBg.withOpacity(0.5)),
                    child: const Icon(FlutterRemix.customer_service_2_line),
                  ),
                ),
              ),
              6.verticalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.call),
                style: Style.interNormal(size: 14, color: Style.textGrey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
