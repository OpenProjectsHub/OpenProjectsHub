import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/application/shop_order/shop_order_provider.dart';
import 'package:shoppingapp/infrastructure/models/data/recipe_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/blur_wrap.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';
import 'package:shoppingapp/presentation/pages/recipe_details/common_material_button.dart';

import '../../theme/app_style.dart';
import 'open_ingredients_button.dart';
import 'recipe_product_item.dart';
import 'riverpod/provider/ingredients_to_cart_provider.dart';
import 'riverpod/provider/ingredients_visible_provider.dart';
import 'riverpod/provider/recipe_details_provider.dart';
import 'widgets/nutrition_item.dart';
import 'widgets/recipe_info_divider.dart';
import 'widgets/recipe_info_item.dart';

@RoutePage()
class RecipeDetailsPage extends ConsumerStatefulWidget {
  final int? shopId;
  final RecipeData recipe;

  const RecipeDetailsPage({super.key, required this.recipe, this.shopId});

  @override
  ConsumerState<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends ConsumerState<RecipeDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref
            .read(ingredientsVisibleProvider.notifier)
            .toggleVisibility(value: false);
        ref.read(ingredientsToCartProvider.notifier).addedProducts(false);
        ref.read(recipeDetailsProvider.notifier).fetchRecipeDetails(
              recipeId: widget.recipe.id,
              checkYourNetwork: () {
                AppHelpers.showNoConnectionSnackBar(
                  context,
                );
              },
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgGrey,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                snap: true,
                floating: true,
                expandedHeight: 300.r,
                toolbarHeight: 56.r,
                backgroundColor: Style.bgGrey,
                automaticallyImplyLeading: false,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(bottom: 8),
                  title: Container(
                    width: double.infinity,
                    height: 56.r,
                    margin: REdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                      minHeight: 56.r,
                    ),
                    decoration: BoxDecoration(
                      color: Style.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: const [
                        BoxShadow(color: Style.shadowCart,offset: Offset(0,4),blurRadius: 10)
                      ]
                    ),
                    child: Text(
                      widget.recipe.translation?.title ?? "",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        letterSpacing: -14 * 0.02,
                        color: Style.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  background: Container(
                    color: Style.bgGrey,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 32,
                          left: 0,
                          right: 0,
                          child: CustomNetworkImage(
                            url: widget.recipe.image ?? "",
                            width: double.infinity,
                            radius: 0,
                            height: 288.r,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      children: [
                        16.verticalSpace,
                        Container(
                          height: 72.r,
                          padding: REdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          color: Style.outlineButtonBorder,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RecipeInfoItem(
                                title: AppHelpers.getTranslation(
                                    TrKeys.activeTime),
                                value: '${widget.recipe.activeTime} min',
                              ),
                              const RecipeInfoDivider(),
                              RecipeInfoItem(
                                title:
                                    AppHelpers.getTranslation(TrKeys.totalTime),
                                value: '${widget.recipe.totalTime} min',
                              ),
                              const RecipeInfoDivider(),
                              RecipeInfoItem(
                                title:
                                    AppHelpers.getTranslation(TrKeys.calories),
                                value: '${widget.recipe.calories}',
                              ),
                            ],
                          ),
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final state = ref.watch(recipeDetailsProvider);
                            return state.isLoading
                                ? Padding(
                                    padding: REdgeInsets.only(top: 34),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Style.brandGreen,
                                        strokeWidth: 4.r,
                                      ),
                                    ),
                                  )
                                : Container(
                                    color: Style.white,
                                    width: double.infinity,
                                    padding:
                                        REdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        34.verticalSpace,
                                        Text(
                                          AppHelpers.getTranslation(
                                              TrKeys.ingredientsList),
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color: Style.black,
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                        16.verticalSpace,
                                       html.Html(data: state.recipeData?.ingredient?.title ?? ""),
                                        66.verticalSpace,
                                        Text(
                                          AppHelpers.getTranslation(
                                              TrKeys.instructions),
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color: Style.black,
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                        16.verticalSpace,
                                        (state.recipeData?.instructions != null
                                            ? html.Html(
                                                data: state.recipeData?.instructions?.title,
                                              )
                                            : const SizedBox.shrink()),
                                        44.verticalSpace,
                                        Text(
                                          AppHelpers.getTranslation(
                                              TrKeys.nutritionInfo),
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color: Style.black,
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                        8.verticalSpace,
                                        (state.recipeData?.nutritions != null
                                            ? ListView.builder(
                                                itemCount: state.recipeData
                                                    ?.nutritions?.length,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return NutritionItem(
                                                    nutritions: state.recipeData
                                                        ?.nutritions?[index],
                                                  );
                                                },
                                              )
                                            : const SizedBox.shrink()),
                                        40.verticalSpace,
                                      ],
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 16.r,
            child: BlurWrap(
              radius: BorderRadius.circular(20.r),
              child: GestureDetector(
                onTap: context.popRoute,
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: Style.black.withOpacity(0.06),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    FlutterRemix.arrow_left_s_line,
                    color: Style.white,
                    size: 24.r,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(recipeDetailsProvider);
          final notifier = ref.read(recipeDetailsProvider.notifier);
          return state.isLoading || state.recipeData == null
              ? const SizedBox.shrink()
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: ref.watch(ingredientsVisibleProvider).isVisible
                          ? ((state.recipeData?.recipeProducts?.length ?? 1) * 108 + 82).r
                          : 0,
                      margin: REdgeInsets.only(bottom: 100),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Style.bgGrey,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, -2),
                            blurRadius: 30.r,
                            spreadRadius: 0,
                            color: Style.shadowCart,
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: state.recipeData?.recipeProducts?.length ?? 0,
                        shrinkWrap: true,
                        padding: REdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return RecipeProductItem(
                            product: state.recipeData?.recipeProducts?[index],
                            onIncrease: () {
                              notifier.increaseRecipeProductCount(index);
                            },
                            onDecrease: () {
                              notifier.decreaseRecipeProductCount(index);
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 100.r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Style.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, -2),
                            blurRadius: 30.r,
                            spreadRadius: 0,
                            color: Style.bgGrey,
                          ),
                        ],
                      ),
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: OpenIngredientsButton(
                              isVisible: ref
                                  .watch(ingredientsVisibleProvider)
                                  .isVisible,
                              onTap: () {
                                ref
                                    .read(ingredientsVisibleProvider.notifier)
                                    .toggleVisibility();
                              },
                            ),
                          ),
                          20.horizontalSpace,
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                final addedState =
                                    ref.watch(ingredientsToCartProvider);
                                return CommonMaterialButton(
                                  height: 50,
                                  color: Style.brandGreen,
                                  text: addedState.added
                                      ? AppHelpers.getTranslation(TrKeys.add)
                                      : '${AppHelpers.getTranslation(TrKeys.add)} ${state.recipeData?.recipeProducts?.length} ${AppHelpers.getTranslation(TrKeys.add)}',
                                  horizontalPadding: 0,
                                  isLoading: addedState.isLoading,
                                  onTap: addedState.added
                                      ? null
                                      : () {
                                          return ref
                                              .read(ingredientsToCartProvider
                                                  .notifier)
                                              .insertProducts(
                                                shopId: widget.shopId,
                                                products: state
                                                    .recipeData?.recipeProducts,
                                                checkYourNetwork: () {
                                                  AppHelpers
                                                      .showNoConnectionSnackBar(
                                                    context,
                                                  );
                                                },
                                                success: () {
                                                  context.router.popUntilRoot();
                                                  ref.read(shopOrderProvider.notifier).getCart(context, () { },isStart: true);
                                                },
                                              );
                                        },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
