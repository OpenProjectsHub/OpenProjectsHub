import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/theme.dart';

class CommonAppBar extends StatelessWidget {
  final Widget child;
  final double height;
  final bool isSearchPage;

  const CommonAppBar({
    super.key,
    required this.child,
    this.height = 76,
     this.isSearchPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height.h+((MediaQuery.of(context).padding.top > 34)
              ? 34.h
              : MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r))),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: isSearchPage ? 10.h : 20.h),
          child: child,
        ),
      ),
    );
  }
}
