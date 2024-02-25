import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme.dart';
import 'animation_button_effect.dart';

class SocialButton extends StatelessWidget {
  final IconData iconData;
  final Function() onPressed;
  final String title;

  const SocialButton({
    super.key,
    required this.iconData,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Style.white,
          minimumSize: Size(96.r,36.r),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              iconData,
              color: Style.textGrey,
              size: 16.r,
            ),
            8.horizontalSpace,
            Text(
              title,
              style: Style.interNormal(
                size: 12,
                color: Style.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
