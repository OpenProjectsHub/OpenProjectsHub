import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class RecommendedItem extends StatelessWidget {
  final CategoryData recipeCategory;

  const RecommendedItem({
    super.key,
    required this.recipeCategory,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(ShopRecipesRoute(
            categoryId: recipeCategory.id,
            categoryTitle: recipeCategory.translation?.title ?? ""));
      },
      child: Container(
        margin: EdgeInsets.only(left: 0, right: 9.r),
        width: MediaQuery.of(context).size.width / 3,
        height: 190.h,
        decoration: BoxDecoration(
            color: Style.transparent,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            border: Border.all(color: Style.borderColor)),
        child: Stack(
          children: [
            CustomNetworkImage(
                url: recipeCategory.img ?? "",
                width: MediaQuery.of(context).size.width / 2,
                height: 190.h,
                radius: 10.r),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      8.horizontalSpace,
                      Expanded(
                        child: Text(
                          recipeCategory.translation?.title ?? "",
                          style: Style.interNormal(
                            size: 12,
                            color: Style.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100.r)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.h, horizontal: 12.w),
                        decoration: BoxDecoration(
                            color: Style.black.withOpacity(0.4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.r))),
                        child: Text(
                          "${recipeCategory.receiptsCount ?? 0}  ${AppHelpers.getTranslation(TrKeys.products)}",
                          style: Style.interNormal(
                            size: 12,
                            color: Style.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
