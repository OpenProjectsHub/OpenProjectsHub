
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpodtemp/application/order/order_provider.dart';
import 'package:riverpodtemp/infrastructure/services/app_helpers.dart';
import 'package:riverpodtemp/infrastructure/services/tr_keys.dart';
import 'package:riverpodtemp/presentation/components/custom_network_image.dart';
import 'package:riverpodtemp/presentation/theme/theme.dart';

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ref.watch(orderProvider).orderData?.deliveryMan == null
          ? const SizedBox.shrink()
          : Column(
              children: [
                16.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                      color: Style.bgGrey,
                      borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      ClipOval(
                        child: CustomNetworkImage(
                          url: ref
                                  .watch(orderProvider)
                                  .orderData
                                  ?.deliveryMan
                                  ?.img ??
                              "",
                          height: 48,
                          width: 48,
                          radius: 0,
                        ),
                      ),
                      12.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${ref.watch(orderProvider).orderData?.deliveryMan?.firstname ?? ""} ${ref.watch(orderProvider).orderData?.deliveryMan?.lastname ?? ""}",
                            style: Style.interSemi(
                              size: 16,
                              color: Style.black,
                            ),
                          ),
                          Text(
                            AppHelpers.getTranslation(TrKeys.driver),
                            style: Style.interRegular(
                              size: 12.sp,
                              color: Style.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
    });
  }
}
