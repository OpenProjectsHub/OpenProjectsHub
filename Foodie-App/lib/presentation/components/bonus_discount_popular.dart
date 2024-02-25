import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/models/data/bonus_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';

import '../../infrastructure/services/tr_keys.dart';
import '../theme/app_style.dart';

class BonusDiscountPopular extends StatelessWidget {
  final bool isPopular;
  final BonusModel? bonus;
  final bool isDiscount;
  final bool isSingleShop;

  const BonusDiscountPopular(
      {super.key,
      required this.isPopular,
      required this.bonus,
      required this.isDiscount,
      this.isSingleShop = false});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        isDiscount && bonus != null && !isPopular
            ? Row(
                children: [
                  Container(
                    width: 22.w,
                    height: 22.h,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Style.red),
                    child: Icon(
                      FlutterRemix.percent_fill,
                      size: 16.r,
                      color: Style.white,
                    ),
                  ),
                  8.horizontalSpace,
                  Container(
                    width: 22.w,
                    height: 22.h,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Style.blueBonus),
                    child: Icon(
                      FlutterRemix.gift_2_fill,
                      size: 16.r,
                      color: Style.white,
                    ),
                  ),
                ],
              )
            : isDiscount && isPopular && bonus == null
            ? Row(
                    children: [
                      Container(
                        width: 22.w,
                        height: 22.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Style.red),
                        child: Icon(
                          FlutterRemix.percent_fill,
                          size: 16.r,
                          color: Style.white,
                        ),
                      ),
                      8.horizontalSpace,
                      Container(
                        width: 22.w,
                        height: 22.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Style.brandGreen),
                        child: Icon(
                          FlutterRemix.flashlight_fill,
                          size: 16.r,
                          color: Style.black,
                        ),
                      ),
                    ],
                  )
                : isDiscount && isPopular && bonus != null
                    ? Row(
                        children: [
                          Container(
                            width: 22.w,
                            height: 22.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Style.red),
                            child: Icon(
                              FlutterRemix.percent_fill,
                              size: 16.r,
                              color: Style.white,
                            ),
                          ),
                          8.horizontalSpace,
                          Container(
                            width: 22.w,
                            height: 22.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Style.brandGreen),
                            child: Icon(
                              FlutterRemix.flashlight_fill,
                              size: 16.r,
                              color: Style.black,
                            ),
                          ),
                          8.horizontalSpace,
                          Container(
                            width: 22.w,
                            height: 22.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Style.blueBonus),
                            child: Icon(
                              FlutterRemix.gift_2_fill,
                              size: 16.r,
                              color: Style.white,
                            ),
                          ),
                        ],
                      )
                    : isPopular && bonus != null && !isDiscount
                        ? Row(
                            children: [
                              Container(
                                width: 22.w,
                                height: 22.h,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Style.blueBonus),
                                child: Icon(
                                  FlutterRemix.gift_2_fill,
                                  size: 16.r,
                                  color: Style.white,
                                ),
                              ),
                              8.horizontalSpace,
                              Container(
                                width: 22.w,
                                height: 22.h,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Style.brandGreen),
                                child: Icon(
                                  FlutterRemix.flashlight_fill,
                                  size: 16.r,
                                  color: Style.black,
                                ),
                              ),
                            ],
                          )
                        : isSingleShop
                            ? singleShop()
                            : Row(
                                children: [
                                  isDiscount
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: Style.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100.r))),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                                vertical: 6.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  FlutterRemix.percent_fill,
                                                  size: 14.r,
                                                  color: Style.white,
                                                ),
                                                4.horizontalSpace,
                                                Text(
                                                  AppHelpers.getTranslation(
                                                          TrKeys.discount)
                                                      .toUpperCase(),
                                                  style: Style.interNoSemi(
                                                    size: 10.sp,
                                                    color: Style.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : bonus != null
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color: Style.blueBonus,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100.r))),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.w,
                                                    vertical: 6.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      FlutterRemix.gift_2_fill,
                                                      size: 14.r,
                                                      color: Style.white,
                                                    ),
                                                    4.horizontalSpace,
                                                    Text(
                                                      AppHelpers.getTranslation(
                                                              TrKeys.bonus)
                                                          .toUpperCase(),
                                                      style: Style.interNoSemi(
                                                        size: 10.sp,
                                                        color: Style.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : isPopular
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      color: Style.brandGreen,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  100.r))),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w,
                                                            vertical: 6.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          FlutterRemix
                                                              .flashlight_fill,
                                                          size: 14.r,
                                                          color: Style.black,
                                                        ),
                                                        4.horizontalSpace,
                                                        Text(
                                                          AppHelpers.getTranslation(
                                                                  TrKeys
                                                                      .popular)
                                                              .toUpperCase(),
                                                          style:
                                                              Style.interNoSemi(
                                                            size: 10,
                                                            color: Style.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                ],
                              )
      ],
    );
  }

  Widget singleShop() {
    return Row(
      children: [
        isDiscount
            ? Container(
                width: 22.w,
                height: 22.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Style.red),
                child: Icon(
                  FlutterRemix.percent_fill,
                  size: 16.r,
                  color: Style.white,
                ),
              )
            : bonus != null
                ? Container(
                    width: 22.w,
                    height: 22.h,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Style.blueBonus),
                    child: Icon(
                      FlutterRemix.gift_2_fill,
                      size: 16.r,
                      color: Style.white,
                    ),
                  )
                : isPopular
                    ? Container(
                        width: 22.w,
                        height: 22.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Style.brandGreen),
                        child: Icon(
                          FlutterRemix.flashlight_fill,
                          size: 16.r,
                          color: Style.black,
                        ),
                      )
                    : isDiscount && isPopular && bonus != null
                        ? Row(
                            children: [
                              Container(
                                width: 22.w,
                                height: 22.h,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Style.red),
                                child: Icon(
                                  FlutterRemix.percent_fill,
                                  size: 16.r,
                                  color: Style.white,
                                ),
                              ),
                              8.horizontalSpace,
                              Container(
                                width: 22.w,
                                height: 22.h,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Style.brandGreen),
                                child: Icon(
                                  FlutterRemix.flashlight_fill,
                                  size: 16.r,
                                  color: Style.black,
                                ),
                              ),
                              8.horizontalSpace,
                              Container(
                                width: 22.w,
                                height: 22.h,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Style.blueBonus),
                                child: Icon(
                                  FlutterRemix.gift_2_fill,
                                  size: 16.r,
                                  color: Style.white,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
      ],
    );
  }
}
