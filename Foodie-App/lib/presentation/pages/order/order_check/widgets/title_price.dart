import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';


// ignore: must_be_immutable
class TitleAndPrice extends StatelessWidget {
  final String title;
  final String? rightTitle;
  final TextStyle textStyle;
  VoidCallback? onRightTap;

  TitleAndPrice({
    super.key,
    required this.title,
    this.rightTitle,
    this.onRightTap,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Style.interRegular(
              size: 16,
              color: Style.black,
            ),
          ),
          GestureDetector(
            onTap: onRightTap ?? (){},
            child: Row(
              children: [
                Text(
                  rightTitle ?? "",
                  style: textStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
