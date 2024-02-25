import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/application/home/home_provider.dart';
import 'package:shoppingapp/application/like/like_notifier.dart';
import 'package:shoppingapp/application/like/like_provider.dart';
import 'package:shoppingapp/application/product/product_provider.dart';
import 'package:shoppingapp/application/shop_order/shop_order_provider.dart';
import 'package:shoppingapp/infrastructure/models/data/local_cart_model.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/app_bars/common_app_bar.dart';
import 'package:shoppingapp/presentation/components/buttons/pop_button.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/pages/home/shimmer/banner_shimmer.dart';
import 'package:shoppingapp/presentation/pages/home/widgets/banner_item.dart';
import 'package:shoppingapp/presentation/pages/shop/widgets/shimmer_product_list.dart';
import 'package:shoppingapp/presentation/pages/shop/widgets/shop_product_item.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

import '../../../application/main/main_provider.dart';
import '../product/product_page.dart';

@RoutePage()
class LikePage extends ConsumerStatefulWidget {
  const LikePage({super.key});

  @override
  ConsumerState<LikePage> createState() => _LikePageState();
}

class _LikePageState extends ConsumerState<LikePage> {
  late LikeNotifier event;
  final RefreshController _bannerController = RefreshController();
  final RefreshController _likeShopController = RefreshController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(likeProvider.notifier).fetchLikeProducts(context);
    });
    _controller.addListener(listen);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    event = ref.read(likeProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _likeShopController.dispose();
    _controller.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = _controller.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      ref.read(mainProvider.notifier).changeScrolling(true);
    } else if (direction == ScrollDirection.forward) {
      ref.read(mainProvider.notifier).changeScrolling(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(likeProvider);
    return Scaffold(
      backgroundColor: Style.bgGrey,
      body: Column(
        children: [
          CommonAppBar(
            child: Text(
              AppHelpers.getTranslation(TrKeys.likedProducts),
              style: Style.interNoSemi(
                size: 18,
                color: Style.black,
              ),
            ),
          ),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              physics: const BouncingScrollPhysics(),
              controller: _likeShopController,
              scrollController: _controller,
              onLoading: () {},
              onRefresh: () {
                event.fetchLikeProducts(context);
                ref.read(homeProvider.notifier).fetchBannerPage(
                    context, _likeShopController,
                    isRefresh: true);
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: 24.h, bottom: MediaQuery.of(context).padding.bottom),
                child: Column(
                  children: [
                    ref.watch(homeProvider).isBannerLoading
                        ? const BannerShimmer()
                        : SizedBox(
                            height: 200.h,
                            child: SmartRefresher(
                              scrollDirection: Axis.horizontal,
                              enablePullDown: false,
                              enablePullUp: true,
                              controller: _bannerController,
                              onLoading: () async {
                                await ref
                                    .read(homeProvider.notifier)
                                    .fetchBannerPage(
                                        context, _bannerController);
                              },
                              child: ListView.builder(
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    ref.watch(homeProvider).banners.length,
                                padding: EdgeInsets.only(left: 16.w),
                                itemBuilder: (context, index) => BannerItem(
                                  banner:
                                      ref.watch(homeProvider).banners[index],
                                ),
                              ),
                            ),
                          ),
                    16.verticalSpace,
                    TitleAndIcon(
                      title: AppHelpers.getTranslation(TrKeys.products),
                    ),
                    16.verticalSpace,
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
                                              AppHelpers
                                                  .showCustomModalBottomDragSheet(
                                                paddingTop:
                                                    MediaQuery.of(context)
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
                                                                  .products[
                                                                      index]
                                                                  .stocks
                                                                  ?.first
                                                                  .id ??
                                                              0), orElse: () {
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
                                                final stock = (state
                                                            .products[index]
                                                            .stocks
                                                            ?.isNotEmpty ??
                                                        false)
                                                    ? state.products[index]
                                                        .stocks?.first
                                                    : state
                                                        .products[index].stock;
                                                if (LocalStorage.instance
                                                    .getToken()
                                                    .isNotEmpty) {
                                                  ref
                                                      .read(shopOrderProvider
                                                          .notifier)
                                                      .addCart(context,
                                                          state.products[index],
                                                          stockId: stock?.id);
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
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const PopButton(),
        ),
      ),
    );
  }

  Widget _resultEmpty() {
    return Column(
      children: [
        32.verticalSpace,
        Image.asset("assets/images/notFound.png"),
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
}
