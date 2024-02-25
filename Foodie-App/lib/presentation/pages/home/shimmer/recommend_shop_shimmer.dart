import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../infrastructure/services/app_helpers.dart';
import '../../../../infrastructure/services/tr_keys.dart';
import '../../../components/title_icon.dart';
import '../../../theme/app_style.dart';

class RecommendShopShimmer extends StatelessWidget {
  const RecommendShopShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndIcon(
          rightTitle: AppHelpers.getTranslation(TrKeys.seeAll),
          isIcon: true,
          title: AppHelpers.getTranslation(TrKeys.recommended),
          onRightTap: () {},
        ),
        12.verticalSpace,
        SizedBox(
            height: 170.h,
            child: AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: false,
                primary: false,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: 4,
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Container(
                        margin: EdgeInsets.only(left: 0, right: 9.r),
                        width: MediaQuery.of(context).size.width / 3,
                        height: 190.h,
                        decoration: BoxDecoration(
                            color: Style.shimmerBase,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                      ),
                    ),
                  ),
                ),
              ),
            )),
        30.verticalSpace,
      ],
    );
  }
}
