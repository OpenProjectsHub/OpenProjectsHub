import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppingapp/infrastructure/services/app_constants.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

import 'order_status_item.dart';

class OrderStatusScreen extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusScreen({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      decoration: BoxDecoration(
          color: Style.bgGrey,
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      padding: EdgeInsets.all(14.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                AppHelpers.getTranslation(
                    AppHelpers.getOrderStatusText(status)),
                style: Style.interNormal(
                  size: 13,
                  color: Style.black,
                ),
              ),
            ],
          ),
          status == OrderStatus.canceled
              ? Row(
                  children: [
                    OrderStatusItem(
                      icon: Icon(
                        Icons.done_all,
                        size: 16.r,
                      ),
                      bgColor: Style.red,
                      isActive: true,
                      isProgress: false,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 6.h,
                      width: 12.w,
                      decoration: const BoxDecoration(
                        color: Style.red,
                      ),
                    ),
                    OrderStatusItem(
                      icon: Icon(
                        Icons.restaurant_rounded,
                        size: 16.r,
                        color: Style.black,
                      ),
                      bgColor: Style.red,
                      isActive: true,
                      isProgress: false,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 6.h,
                      width: 12.w,
                      decoration: const BoxDecoration(
                        color: Style.red,
                      ),
                    ),
                    OrderStatusItem(
                      icon: SvgPicture.asset(
                        "assets/svgs/delivery2.svg",
                        width: 20.w,
                      ),
                      bgColor: Style.red,
                      isActive: true,
                      isProgress: false,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 6.h,
                      width: 12.w,
                      decoration: const BoxDecoration(
                        color: Style.red,
                      ),
                    ),
                    OrderStatusItem(
                      icon: Icon(
                        Icons.flag,
                        size: 16.r,
                      ),
                      bgColor: Style.red,
                      isActive: true,
                      isProgress: false,
                    ),
                  ],
                )
              : status == OrderStatus.delivered
                  ? Row(
                      children: [
                        OrderStatusItem(
                          icon: Icon(
                            Icons.done_all,
                            size: 16.r,
                          ),
                          bgColor: Style.brandGreen,
                          isActive: true,
                          isProgress: false,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 6.h,
                          width: 12.w,
                          decoration: const BoxDecoration(
                            color: Style.brandGreen,
                          ),
                        ),
                        OrderStatusItem(
                          icon: Icon(
                            Icons.restaurant_rounded,
                            size: 16.r,
                            color: Style.black,
                          ),
                          bgColor: Style.brandGreen,
                          isActive: true,
                          isProgress: false,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 6.h,
                          width: 12.w,
                          decoration: const BoxDecoration(
                            color: Style.brandGreen,
                          ),
                        ),
                        OrderStatusItem(
                          icon: SvgPicture.asset(
                            "assets/svgs/delivery2.svg",
                            width: 20.w,
                          ),
                          bgColor: Style.brandGreen,
                          isActive: true,
                          isProgress: false,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 6.h,
                          width: 12.w,
                          decoration: const BoxDecoration(
                            color: Style.brandGreen,
                          ),
                        ),
                        OrderStatusItem(
                          icon: Icon(
                            Icons.flag,
                            size: 16.r,
                          ),
                          bgColor: Style.brandGreen,
                          isActive: true,
                          isProgress: false,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        OrderStatusItem(
                          icon: Icon(
                            Icons.done_all,
                            size: 16.r,
                          ),
                          isActive: status != OrderStatus.open,
                          isProgress: status == OrderStatus.open,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 6.h,
                          width: 12.w,
                          decoration: BoxDecoration(
                            color: status != OrderStatus.open
                                ? Style.brandGreen
                                : Style.white,
                          ),
                        ),
                        OrderStatusItem(
                          icon: Icon(
                            Icons.restaurant_rounded,
                            size: 16.r,
                            color:  Style.black,
                          ),
                          isActive: status == OrderStatus.ready ||
                              status == OrderStatus.onWay,
                          isProgress: status == OrderStatus.accepted,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 6.h,
                          width: 12.w,
                          decoration: BoxDecoration(
                            color: status == OrderStatus.ready ||
                                    status == OrderStatus.onWay
                                ? Style.brandGreen
                                : Style.white,
                          ),
                        ),
                        OrderStatusItem(
                          icon: SvgPicture.asset(
                            status == OrderStatus.onWay
                                ? "assets/svgs/delivery2.svg"
                                :  "assets/svgs/delivery.svg",
                            width: 20.w,
                          ),
                          isActive: status == OrderStatus.onWay,
                          isProgress: status == OrderStatus.ready ||
                              status == OrderStatus.delivered,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: 6.h,
                          width: 12.w,
                          decoration: const BoxDecoration(
                            color: Style.white,
                          ),
                        ),
                        OrderStatusItem(
                          icon: Icon(
                            Icons.flag,
                            size: 16.r,
                          ),
                          isActive: false,
                          isProgress: false,
                        ),
                      ],
                    )
        ],
      ),
    );
  }
}
