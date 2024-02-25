import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/models/data/recipe_data.dart';
import 'package:shoppingapp/presentation/components/loading.dart';

import 'grid_recipe_item.dart';


class GridRecipesBody extends StatelessWidget {
  final bool isLoading;
  final List<RecipeData> recipes;
  final double? bottomPadding;

  const GridRecipesBody({
    super.key,
    this.isLoading = false,
    this.recipes = const [],

    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : GridView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: recipes.length,
            padding: REdgeInsets.only(top: 24, bottom: bottomPadding ?? 100,left: 16.r,right: 16.r),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 188 / 328,
              mainAxisSpacing: 18.r,
              crossAxisSpacing: 8.r,
              crossAxisCount: 2,
            ),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GridRecipeItem(recipe: recipes[index],);
            },
          );
  }
}
