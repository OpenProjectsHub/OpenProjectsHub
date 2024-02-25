import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';

import '../theme/theme.dart';

// ignore: must_be_immutable
class TitleAndIcon extends StatelessWidget {
  final String title;
  final double titleSize;
  final String? rightTitle;
  final bool isIcon;
  final Color rightTitleColor;
  final double paddingHorizontalSize;
   VoidCallback? onRightTap;

   TitleAndIcon({
    super.key,
    this.isIcon = false,
    required this.title,
    this.rightTitle,
    this.rightTitleColor = Style.black,
    this.onRightTap,
     this.titleSize = 20,
     this.paddingHorizontalSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.instance.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontalSize.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: Style.interNoSemi(
                  size: titleSize.sp,
                  color: Style.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: onRightTap ?? (){},
              child: Row(
                children: [
                  Text(
                    rightTitle ?? "",
                    style: Style.interRegular(
                      size: 14,
                      color: rightTitleColor,
                    ),
                  ),
                  isIcon
                      ?  Icon(isLtr ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left)
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
