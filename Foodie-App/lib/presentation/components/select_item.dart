import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class SelectItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final String title;
  final String? desc;
  const SelectItem({super.key, required this.onTap, required this.isActive, required this.title, this.desc, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Style.white,
              borderRadius:
              BorderRadius.all(Radius.circular(10.r))),
          child: Padding(
            padding: EdgeInsets.all(18.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 18.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                      color: isActive
                          ? Style.brandGreen
                          : Style.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: isActive
                              ? Style.black
                              : Style.textGrey,
                          width:
                          isActive ? 4.r : 2.r)),
                ),
                16.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Style.interNormal(
                        size: 16,
                        color: Style.black,
                      ),
                    ),
                    desc != null  ? SizedBox(
                      width: MediaQuery.of(context).size.width/1.5,
                      child: Text(
                        desc ?? "",
                        style: Style.interNormal(
                          size: 14,
                          color: Style.textGrey,
                        ),
                      ),
                    ) : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
