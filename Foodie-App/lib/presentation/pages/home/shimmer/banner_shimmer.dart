import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../theme/app_style.dart';

class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 200.h,
      margin: EdgeInsets.only(bottom: 30.h),
      child: AnimationLimiter(
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          padding: EdgeInsets.only(left: 16.w),
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Container(
                  margin: EdgeInsets.only(right: 6.r),
                  height: 180.h,
                  width: MediaQuery.of(context).size.width - 46,
                  decoration: BoxDecoration(
                    color: Style.shimmerBase,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
