import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppingapp/infrastructure/models/data/refund_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';
import 'package:intl/intl.dart' as intl;

class RefundInfoScreen extends StatelessWidget {
  final RefundModel? refundModel;

  const RefundInfoScreen({super.key, required this.refundModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 36.h,
                    width: 36.w,
                    decoration: BoxDecoration(
                      color: (refundModel?.status == "pending"
                          ? Style.brandGreen
                          : Style.bgGrey),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: refundModel?.status == "pending"
                          ? Stack(
                              children: [
                                Center(
                                    child: SvgPicture.asset(
                                        "assets/svgs/orderTime.svg")),
                                Center(
                                  child: Text(
                                    "15",
                                    style: Style.interNoSemi(
                                      size: 10,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Icon(
                        refundModel?.status == "accepted"
                                  ? Icons.done_all
                                  : Icons.cancel_outlined,
                              size: 16.r,
                            ),
                    ),
                  ),
                  8.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.reFound),
                    style: Style.interNoSemi(
                      size: 16,
                      color: Style.black,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    refundModel?.status ?? "",
                    style: Style.interNormal(
                      size: 14,
                      color: Style.black,
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              Row(
                children: [
                  Text(
                    "#${AppHelpers.getTranslation(TrKeys.id)}${refundModel?.id ?? ""}",
                    style: Style.interNormal(
                      size: 14,
                      color: Style.textGrey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    width: 6.w,
                    height: 6.h,
                    decoration: const BoxDecoration(
                        color: Style.textGrey, shape: BoxShape.circle),
                  ),
                  Text(
                    intl.DateFormat("MMM dd, HH:MM").format(refundModel?.createdAt ?? DateTime.now()),
                    style: Style.interNormal(
                      size: 14,
                      color: Style.textGrey,
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              const Divider(
                color: Style.textGrey,
              ),
              16.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.cause),
                    style: Style.interRegular(
                      size: 14,
                      color: Style.textGrey,
                    ),
                  ),
                  Text(
                    refundModel?.cause ?? "",
                    style: Style.interNoSemi(
                      size: 16,
                      color: Style.black,
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              const Divider(
                color: Style.textGrey,
              ),
              16.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.answer),
                    style: Style.interRegular(
                      size: 14,
                      color: Style.textGrey,
                    ),
                  ),
                  Text(
                    refundModel?.answer ?? "",
                    style: Style.interNoSemi(
                      size: 16,
                      color: Style.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        16.verticalSpace,
      ],
    );
  }
}
