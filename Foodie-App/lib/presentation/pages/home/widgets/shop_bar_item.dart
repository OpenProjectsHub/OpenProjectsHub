import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/infrastructure/models/data/story_data.dart';
import 'package:shoppingapp/presentation/components/shop_avarat.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class ShopBarItem extends StatelessWidget {
  final RefreshController controller;
  final StoryModel? story;
  final int index;

  const ShopBarItem({
    super.key,
    required this.story,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(StoryListRoute(controller: controller, index: index));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Style.brandGreen, width: 2.r)),
              child: ShopAvatar(
                shopImage: story?.logoImg ?? "",
                size: 64,
                padding: 6,
                radius: 32,
                bgColor: Style.transparent,
              ),
            ),
            7.verticalSpace,
            SizedBox(
              width: 72.r,
              child: Center(
                child: Text(
                  story?.title ?? "",
                  style: Style.interNormal(
                    size: 12,
                    color: Style.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
