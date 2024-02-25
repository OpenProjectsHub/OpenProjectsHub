import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shoppingapp/application/order/order_provider.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,ref,child) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.order),
                    style: Style.interNoSemi(
                      size: 16,
                      color: Style.black,
                    ),
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      Text(
                        "#${AppHelpers.getTranslation(TrKeys.id)}${ref.read(orderProvider).orderData?.id ?? 0}",
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
                        DateFormat("MMM dd, HH:MM").format(ref.read(orderProvider).orderData?.createdAt ?? DateTime.now()),
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
                        AppHelpers.getTranslation(TrKeys.deliveryAddress),
                        style: Style.interRegular(
                          size: 14,
                          color: Style.textGrey,
                        ),
                      ),
                      Text(
                        ref.watch(orderProvider).orderData?.address?.address ?? "",
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
                ],
              ),
            )
          ],
        );
      }
    );
  }
}
