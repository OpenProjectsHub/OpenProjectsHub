import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/application/filter/filter_provider.dart';
import 'package:shoppingapp/application/product/product_provider.dart';
import 'package:shoppingapp/application/shop_order/shop_order_provider.dart';
import 'package:shoppingapp/infrastructure/models/data/local_cart_model.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/presentation/components/app_bars/common_app_bar.dart';
import 'package:shoppingapp/presentation/components/buttons/pop_button.dart';
import 'package:shoppingapp/presentation/pages/product/product_page.dart';
import 'package:shoppingapp/presentation/pages/shop/widgets/shimmer_product_list.dart';
import 'package:shoppingapp/presentation/pages/shop/widgets/shop_product_item.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';

import '../../../../application/filter/filter_notifier.dart';
import '../../../../infrastructure/services/tr_keys.dart';
import '../../../theme/app_style.dart';


@RoutePage()
class ResultFilterPage extends ConsumerStatefulWidget {
  const ResultFilterPage({super.key});

  @override
  ConsumerState<ResultFilterPage> createState() => _ResultFilterState();
}

class _ResultFilterState extends ConsumerState<ResultFilterPage> {
  late FilterNotifier event;
  final RefreshController _shopController = RefreshController();
  final RefreshController _restaurantController = RefreshController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(filterProvider.notifier).fetchProduct(context);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    event = ref.read(filterProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _shopController.dispose();
    _restaurantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(filterProvider);
    return Scaffold(
      body: Column(
        children: [
          CommonAppBar(
            child: Text(
              AppHelpers.getTranslation(TrKeys.products),
              style: Style.interNoSemi(size: 18.sp),
            ),
          ),
          Expanded(
            child: SmartRefresher(
              controller: _restaurantController,
              enablePullUp: true,
              enablePullDown: true,
              onLoading: () {
                event.fetchRestaurantPage(context, _restaurantController);
              },
              onRefresh: () {
                event.fetchRestaurantPage(context, _restaurantController,
                    isRefresh: true);
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    24.verticalSpace,
                    state.isProductLoading
                        ? const ShimmerProductList()
                        : state.products.isEmpty
                            ? _resultEmpty()
                            : AnimationLimiter(
                                child: GridView.builder(
                                  padding: EdgeInsets.only(
                                      right: 12.w, left: 12.w, bottom: 96.h),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.66.r,
                                          crossAxisCount: 2,
                                          mainAxisExtent: 250.r),
                                  itemCount: state.products.length,
                                  itemBuilder: (context, index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      columnCount: state.products.length,
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      child: ScaleAnimation(
                                        scale: 0.5,
                                        child: FadeInAnimation(
                                          child: GestureDetector(
                                            onTap: () {
                                              AppHelpers.showCustomModalBottomDragSheet(
                                                paddingTop: MediaQuery.of(context)
                                                    .padding
                                                    .top +
                                                    100.h,
                                                context: context,
                                                modal: (c) => ProductScreen(
                                                  data: state.products[index],
                                                  controller: c,
                                                ),
                                                isDarkMode: false,
                                                isDrag: true,
                                                radius: 16,
                                              );
                                            },
                                            child: ShopProductItem(
                                              product: state.products[index],
                                              count: LocalStorage.instance
                                                  .getCartLocal()
                                                  .firstWhere(
                                                      (element) =>
                                                          element.stockId ==
                                                          (state
                                                              .products[index]
                                                              .stocks
                                                              ?.first
                                                              .id), orElse: () {
                                                return CartLocalModel(
                                                    count: 0, stockId: 0);
                                              }).count,
                                              isAdd: (LocalStorage.instance
                                                  .getCartLocal()
                                                  .map((item) => item.stockId)
                                                  .contains(state
                                                      .products[index]
                                                      .stocks
                                                      ?.first
                                                      .id)),
                                              addCount: () {
                                                ref
                                                    .read(shopOrderProvider
                                                        .notifier)
                                                    .addCount(
                                                      context: context,
                                                      localIndex: LocalStorage
                                                          .instance
                                                          .getCartLocal()
                                                          .findIndex(state
                                                              .products[index]
                                                              .stocks
                                                              ?.first
                                                              .id),
                                                    );
                                              },
                                              removeCount: () {
                                                ref
                                                    .read(shopOrderProvider
                                                        .notifier)
                                                    .removeCount(
                                                      context: context,
                                                      localIndex: LocalStorage
                                                          .instance
                                                          .getCartLocal()
                                                          .findIndex(state
                                                              .products[index]
                                                              .stocks
                                                              ?.first
                                                              .id),
                                                    );
                                              },
                                              addCart: () {
                                                if (LocalStorage.instance
                                                    .getToken()
                                                    .isNotEmpty) {
                                                  ref
                                                      .read(shopOrderProvider
                                                          .notifier)
                                                      .addCart(
                                                          context,
                                                          state
                                                              .products[index]);
                                                  ref
                                                      .read(productProvider
                                                          .notifier)
                                                      .createCart(
                                                          context,
                                                          state.products[index]
                                                                  .shopId ??
                                                              0, () {
                                                    ref
                                                        .read(shopOrderProvider
                                                            .notifier)
                                                        .getCart(
                                                            context, () {});
                                                  },
                                                          product: state
                                                              .products[index]);
                                                } else {
                                                  context.pushRoute(
                                                      const LoginRoute());
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: const PopButton(),
      ),
    );
  }
}

Widget _resultEmpty() {
  return Column(
    children: [
      Lottie.asset("assets/lottie/empty-box.json"),
      Text(
        AppHelpers.getTranslation(TrKeys.nothingFound),
        style: Style.interSemi(size: 18.sp),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Text(
          AppHelpers.getTranslation(TrKeys.trySearchingAgain),
          style: Style.interRegular(size: 14.sp),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
