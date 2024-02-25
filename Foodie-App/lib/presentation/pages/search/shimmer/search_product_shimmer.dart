import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../components/title_icon.dart';
import '../../../theme/app_style.dart';

class SearchProductShimmer extends StatelessWidget {
  const SearchProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndIcon(
            title: "Products",
            rightTitle: "Found results"),
        20.verticalSpace,
        AnimationLimiter(
          child: ListView.builder(
              padding: EdgeInsets.only(
                  right: 16.w,
                  left: 16.w,
                  bottom: MediaQuery.of(context).padding.bottom),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Container(
                        height: 108.h,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Style.shimmerBase,
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          boxShadow: [
                            BoxShadow(
                              color: Style.white.withOpacity(0.04),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
