import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class TabBarItem extends StatelessWidget {
  final bool isShopTabBar;
  final String title;
  final int index;
  final int? currentIndex;
  final VoidCallback onTap;

  const TabBarItem(
      {super.key,
      required this.title,
      required this.index,
        this.isShopTabBar = false,
         this.currentIndex,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: isShopTabBar ?  (currentIndex == index ? Style.brandGreen : Style.white) :  Style.white,
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
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
        margin: isShopTabBar ? EdgeInsets.only(left: index == 0 ? 16.w : 0, right: 9.w) : EdgeInsets.only(right: 9.w),
        child: Text(
          title,
          style: Style.interNormal(
            size: 13,
            color: Style.black,
          ),
        ),
      ),
    );
  }
}
