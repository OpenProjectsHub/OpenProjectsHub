
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/presentation/components/buttons/animation_button_effect.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String? count;
  final IconData icon;
  final bool isCount;
  final bool isLtr;
  final VoidCallback onTap;

  const ProfileItem(
      {super.key,
      required this.title,
      required this.icon,
      this.isCount = false,
      this.count,
      required this.onTap,
      required this.isLtr});

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Style.white,
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon),
                    14.horizontalSpace,
                    Text(
                      title,
                      style: Style.interNormal(
                        size: 14,
                        color: Style.black,
                      ),
                    ),
                    12.horizontalSpace,
                    isCount
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 14.w),
                            decoration: BoxDecoration(
                                color: Style.brandGreen,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.r))),
                            child: Text(
                              count ?? '',
                              style: Style.interNormal(
                                size: 14,
                                color: Style.black,
                              ),
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
                Icon(
                  isLtr
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_left,
                  color: Style.arrowRightProfileButton,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
