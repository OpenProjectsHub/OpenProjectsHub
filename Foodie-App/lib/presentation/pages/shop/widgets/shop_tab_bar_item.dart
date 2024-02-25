import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class ShopTabBarItem extends StatelessWidget {
  final String title;
  final bool isActive;


  const ShopTabBarItem(
      {super.key,
        required this.title,
        required this.isActive,
      });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isActive ? Style.brandGreen :  Style.white,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        boxShadow: [
          BoxShadow(
            color: Style.white.withOpacity(0.07),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
      margin: EdgeInsets.only(right: 9.w,top: 24.h),
      child: Text(
        title,
        style: Style.interNormal(
          size: 13,
          color: Style.black,
        ),
      ),
    );
  }
}
