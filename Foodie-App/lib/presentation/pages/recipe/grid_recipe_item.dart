import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/infrastructure/models/data/recipe_data.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';

class GridRecipeItem extends StatelessWidget {
  final RecipeData recipe;

  const GridRecipeItem({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(
          RecipeDetailsRoute(recipe: recipe),
        );
      },
      child: Container(
        height: 330.r,
        width: 188.r,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Style.white,
            border: Border.all(color: Style.borderColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                topLeft: Radius.circular(10.r),
              ),
              child: CustomNetworkImage(
                url: recipe.image ?? "",
                height: 151,
                width: double.infinity,
                radius: 0,
              ),
            ),
            Expanded(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      recipe.translation?.title ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: Style.black,
                        letterSpacing: -14 * 0.02,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          height: 1.r,
                          thickness: 1.r,
                          color: Style.divider,
                        ),
                        8.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              FlutterRemix.time_fill,
                              size: 18.r,
                              color: Style.brandGreen,
                            ),
                            Text(
                              '${recipe.totalTime} min',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Style.brandGreen,
                                letterSpacing: -14 * 0.02,
                              ),
                            ),
                            Container(
                              width: 4.r,
                              height: 4.r,
                              margin: EdgeInsets.symmetric(horizontal: 4.r),
                              decoration: const BoxDecoration(
                                  color: Style.textGrey,
                                  shape: BoxShape.circle),
                            ),
                            Icon(
                              FlutterRemix.restaurant_fill,
                              size: 18.r,
                              color: Style.brandGreen,
                            ),
                            Text(
                              '${recipe.calories} kkal',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Style.brandGreen,
                                letterSpacing: -14 * 0.02,
                              ),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        Divider(
                          height: 1.r,
                          thickness: 1.r,
                          color: Style.divider,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomNetworkImage(
                          url: recipe.shop?.logoImg ?? "",
                          height: 30,
                          width: 30,
                          radius: 15,
                        ),
                        9.horizontalSpace,
                        Text(
                          recipe.shop?.translation?.title ?? "",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Style.textGrey,
                            letterSpacing: -14 * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
