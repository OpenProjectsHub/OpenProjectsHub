import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../theme/app_style.dart';

class ShimmerProductList extends StatelessWidget {
  const ShimmerProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        padding: EdgeInsets.only(right: 12.w,left: 12.w,bottom: 96.h,top: 24.r),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.66.r, crossAxisCount: 2),
        itemCount: 4,
        itemBuilder: (context, index) {
          return  AnimationConfiguration.staggeredGrid(
            columnCount: 4,
            position: index,
            duration: const Duration(milliseconds: 375),
            child:  ScaleAnimation(
              scale: 0.5,
              child: FadeInAnimation(
                child: Container(
                  margin: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                      color: Style.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  width: double.infinity,
                  height: 150.h,
                  child: Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      color:  Style.shimmerBase,
                      borderRadius: BorderRadius.circular(10.r/2),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
