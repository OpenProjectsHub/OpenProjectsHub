import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_style.dart';

class SearchCategoryShimmer extends StatelessWidget {
  const SearchCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 36.h,
          child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              padding: EdgeInsets.only(left: 16.w),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color:  Style.shimmerBase,
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Style.white.withOpacity(0.07),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  width: 100.w,
                  height: 64.h,
                  margin: EdgeInsets.only(right: 9.w),
                );
              }),
        ),
        30.verticalSpace,
      ],
    );
  }
}
