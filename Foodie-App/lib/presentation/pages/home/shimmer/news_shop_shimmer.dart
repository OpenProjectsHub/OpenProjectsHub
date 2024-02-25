import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';

import '../../../../infrastructure/services/app_helpers.dart';
import '../../../../infrastructure/services/tr_keys.dart';
import 'market_shimmer.dart';

class NewsShopShimmer extends StatelessWidget {
  final String title;

  const NewsShopShimmer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndIcon(
          rightTitle: AppHelpers.getTranslation(TrKeys.seeAll),
          isIcon: true,
          title: title,
          onRightTap: () {},
        ),
        12.verticalSpace,
        SizedBox(
            height: 246.h,
            child: AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: false,
                primary: false,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: MarketShimmer(index: index),
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
