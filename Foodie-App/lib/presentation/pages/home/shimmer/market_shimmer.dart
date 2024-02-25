import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_style.dart';

class MarketShimmer extends StatelessWidget {
  final bool isSimpleShop;
  final bool isShop;
  final int index;

  const MarketShimmer(
      {super.key,
      this.isSimpleShop = false,
      required this.index,
       this.isShop = false});

  @override
  Widget build(BuildContext context) {
    return isShop ? Container(
      margin: EdgeInsets.only(left: index == 0 ? 16.r : 0, right: 8.r),
      width: 134.w,
      height: 130.h,
      decoration: BoxDecoration(
          color: Style.shimmerBase,
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
    ) : Container(
      margin: isSimpleShop
          ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h)
          : EdgeInsets.only(left: index == 0 ? 16.r : 0, right: 8.r),
      width: 268.w,
      height: 260.h,
      decoration: BoxDecoration(
          color: Style.shimmerBase,
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
    );
  }
}
