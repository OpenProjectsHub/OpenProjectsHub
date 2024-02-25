// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riverpodtemp/presentation/theme/theme.dart';

class OrderStatusItem extends StatelessWidget {
  final Widget icon;
  final bool isActive;
  final bool isProgress;
  final Color bgColor;

  const OrderStatusItem(
      {super.key,
      required this.icon,
      required this.isActive,
      required this.isProgress,
      this.bgColor = Style.brandGreen});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
          color: isActive ? bgColor : Style.white, shape: BoxShape.circle),
      child: Stack(
        children: [
          Positioned(top: 10.h, left: 10.w, child: icon),
          isProgress
              ? SvgPicture.asset(
                  "assets/svgs/orderTime.svg",
                  color: Style.brandGreen,
                  width: 36.w,
                  height: 36.h,
                )
              : SizedBox(
                  width: 36.w,
                  height: 36.h,
                ),
        ],
      ),
    );
  }
}
