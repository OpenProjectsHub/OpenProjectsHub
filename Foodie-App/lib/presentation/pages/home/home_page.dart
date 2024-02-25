import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/application/currency/currency_provider.dart';
import 'package:shoppingapp/application/home/home_notifier.dart';
import 'package:shoppingapp/application/home/home_provider.dart';
import 'package:shoppingapp/application/home/home_state.dart';
import 'package:shoppingapp/application/map/view_map_provider.dart';
import 'package:shoppingapp/application/product/product_provider.dart';
import 'package:shoppingapp/application/shop_order/shop_order_provider.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/loading.dart';
import 'package:shoppingapp/presentation/pages/home/app_bar_home.dart';
import 'package:shoppingapp/presentation/pages/home/category_screen.dart';
import 'package:shoppingapp/presentation/pages/home/filter_category_product.dart';
import 'package:shoppingapp/presentation/pages/product/product_page.dart';
import 'package:shoppingapp/presentation/pages/shop/widgets/shop_product_item.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';
import 'package:upgrader/upgrader.dart';
import '../../../infrastructure/models/data/local_cart_model.dart';
import '../../components/title_icon.dart';
import 'product_by_category.dart';
import 'shimmer/banner_shimmer.dart';
import 'widgets/add_address.dart';
import 'widgets/banner_item.dart';
import 'widgets/recommended_item.dart';
import 'widgets/shop_bar_item.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late HomeNotifier event;
  late RefreshController _bannerController;
  late RefreshController _productController;
  late RefreshController _categoryController;
  late RefreshController _storyController;
  late RefreshController _popularController;

  @override
  void initState() {
    _bannerController = RefreshController();
    _productController = RefreshController();
    _categoryController = RefreshController();
    _storyController = RefreshController();
    _popularController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier)
        ..fetchBranches(context, false)
        ..setAddress()
        ..fetchBanner(context)
        ..fetchStore(context)
        ..fetchProductsWithCheckBranch(context)
        ..fetchProductsPopular(context)
        ..fetchRecipeCategory(context)
        ..fetchCategories(context);
      ref.read(viewMapProvider.notifier).checkAddress();
      ref.read(currencyProvider.notifier).fetchCurrency(context);
      if (LocalStorage.instance.getToken().isNotEmpty) {
        ref
            .read(shopOrderProvider.notifier)
            .getCart(context, () {}, isStart: true);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    event = ref.read(homeProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _categoryController.dispose();
    _productController.dispose();
    _storyController.dispose();
    _popularController.dispose();
    super.dispose();
  }

  void _onLoading(HomeState state) {
    if (state.isSelectCategoryLoading == 0) {
      event.fetchCategoriesPage(context, _productController);
    } else {
      event.fetchFilterProductsPage(context, _productController);
    }
  }

  void _onRefresh(HomeState state) {
    state.isSelectCategoryLoading == 0
        ? (event
          ..fetchBannerPage(context, _productController, isRefresh: true)
          ..fetchProductsPage(context, _productController, isRefresh: true)
          ..fetchCategoriesPage(context, _productController, isRefresh: true)
          ..fetchRecipeCategoryPage(context, _productController,
              isRefresh: true)
          ..fetchStorePage(context, _productController, isRefresh: true)
          ..fetchProductsPopularPage(context, _productController,
              isRefresh: true))
        : event.fetchFilterProductsPage(context, _productController,
            isRefresh: true);
    _productController.resetNoData();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final stateCart = ref.watch(shopOrderProvider).cart?.userCarts?.first;
    final bool isDarkMode = LocalStorage.instance.getAppThemeMode();
    final bool isLtr = LocalStorage.instance.getLangLtr();
    ref.listen(viewMapProvider, (previous, next) {
      if (!next.isSetAddress &&
          !(previous?.isSetAddress ?? false == next.isSetAddress)) {
        AppHelpers.showAlertDialog(context: context, child: const AddAddress());
      }
    });
    return UpgradeAlert(
      child: Directionality(
        textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          backgroundColor: isDarkMode ? Style.mainBackDark : Style.bgGrey,
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            physics: const BouncingScrollPhysics(),
            controller: _productController,
            header: WaterDropMaterialHeader(
              distance: 160.h,
              backgroundColor: Style.white,
              color: Style.textGrey,
            ),
            onLoading: () => _onLoading(state),
            onRefresh: () => _onRefresh(state),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 32.h),
                child: Column(
                  children: [
                    AppBarHome(
                      state: state,
                      event: event,
                      refreshController: _productController,
                    ),
                    24.verticalSpace,
                    CategoryScreen(
                      state: state,
                      event: event,
                      categoryController: _categoryController,
                      restaurantController: _productController,
                    ),
                    state.isSelectCategoryLoading == -1
                        ? const Loading()
                        : state.isSelectCategoryLoading == 0
                            ? _body(stateCart, state, context)
                            : FilterCategoryProduct(
                                stateCart: stateCart,
                                state: state,
                                event: event,
                              ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(dynamic stateCart, HomeState state, BuildContext context) {
    return Column(
      children: [
        state.story?.isNotEmpty ?? false
            ? SizedBox(
                height: 110.h,
                child: SmartRefresher(
                  controller: _storyController,
                  scrollDirection: Axis.horizontal,
                  enablePullDown: false,
                  enablePullUp: true,
                  primary: false,
                  onLoading: () async {
                    await event.fetchStorePage(context, _storyController);
                  },
                  child: AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.story?.length ?? 0,
                      padding: EdgeInsets.only(left: 16.w),
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ShopBarItem(
                              index: index,
                              controller: _storyController,
                              story: state.story?[index]?.first,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        16.verticalSpace,
        state.isBannerLoading
            ? const BannerShimmer()
            : Container(
                height: state.banners.isNotEmpty ? 200.h : 0,
                margin: EdgeInsets.only(
                    bottom: state.banners.isNotEmpty ? 30.h : 0),
                child: SmartRefresher(
                  scrollDirection: Axis.horizontal,
                  enablePullDown: false,
                  enablePullUp: true,
                  primary: false,
                  controller: _bannerController,
                  onLoading: () async {
                    await event.fetchBannerPage(context, _bannerController);
                  },
                  child: AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.banners.length,
                      padding: EdgeInsets.only(left: 16.w),
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: BannerItem(
                              banner: state.banners[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        Column(
          children: [
            state.recipesCategory.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleAndIcon(
                        title: AppHelpers.getTranslation(TrKeys.recipes),
                        rightTitle: AppHelpers.getTranslation(TrKeys.seeAll),
                        onRightTap: () {
                          context.pushRoute(RecommendedRoute());
                        },
                      ),
                      16.verticalSpace,
                      SizedBox(
                        height: 190.h,
                        child: AnimationLimiter(
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.recipesCategory.length,
                            padding: EdgeInsets.only(left: 16.w),
                            itemBuilder: (context, index) =>
                                AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: RecommendedItem(
                                      recipeCategory:
                                          state.recipesCategory[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            16.verticalSpace,
            state.productsPopular.isNotEmpty
                ? Column(
                    children: [
                      TitleAndIcon(
                        title:
                            "${AppHelpers.getTranslation(TrKeys.popular)} ${AppHelpers.getTranslation(TrKeys.products)}",
                      ),
                      16.verticalSpace,
                      SizedBox(
                        height: 250.h,
                        child: SmartRefresher(
                          controller: _popularController,
                          scrollDirection: Axis.horizontal,
                          enablePullDown: false,
                          enablePullUp: true,
                          primary: false,
                          onLoading: () async {
                            await event.fetchProductsPopularPage(
                                context, _popularController);
                          },
                          child: AnimationLimiter(
                            child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.productsPopular.length,
                              padding: EdgeInsets.only(left: 16.w),
                              itemBuilder: (context, index) =>
                                  AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
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
                                            data: state.productsPopular[index],
                                            controller: c,
                                          ),
                                          isDarkMode: false,
                                          isDrag: true,
                                          radius: 16,
                                        );
                                      },
                                      child: SizedBox(
                                        width: 180.r,
                                        child: ShopProductItem(
                                          product: state.productsPopular[index],
                                          count: LocalStorage.instance
                                              .getCartLocal()
                                              .firstWhere(
                                                  (element) =>
                                                      element.stockId ==
                                                      (state
                                                          .productsPopular[
                                                              index]
                                                          .stock
                                                          ?.id), orElse: () {
                                            return CartLocalModel(
                                                count: 0, stockId: 0);
                                          }).count,
                                          isAdd: (LocalStorage.instance
                                              .getCartLocal()
                                              .map((item) => item.stockId)
                                              .contains(state
                                                  .productsPopular[index]
                                                  .stock
                                                  ?.id)),
                                          addCount: () {
                                            ref
                                                .read(
                                                    shopOrderProvider.notifier)
                                                .addCount(
                                                  context: context,
                                                  localIndex: LocalStorage
                                                      .instance
                                                      .getCartLocal()
                                                      .findIndex(state
                                                          .productsPopular[
                                                              index]
                                                          .stock
                                                          ?.id),
                                                );
                                          },
                                          removeCount: () {
                                            ref
                                                .read(
                                                    shopOrderProvider.notifier)
                                                .removeCount(
                                                  context: context,
                                                  localIndex: LocalStorage
                                                      .instance
                                                      .getCartLocal()
                                                      .findIndex(state
                                                          .productsPopular[
                                                              index]
                                                          .stock
                                                          ?.id),
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
                                                      state.productsPopular[
                                                          index]);
                                              ref
                                                  .read(
                                                      productProvider.notifier)
                                                  .createCart(
                                                      context,
                                                      state
                                                              .productsPopular[
                                                                  index]
                                                              .shopId ??
                                                          0, () {
                                                ref
                                                    .read(shopOrderProvider
                                                        .notifier)
                                                    .getCart(context, () {});
                                              },
                                                      product:
                                                          state.productsPopular[
                                                              index]);
                                            } else {
                                              context.pushRoute(
                                                  const LoginRoute());
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.allProducts.length,
              itemBuilder: (context, index) {
                return ProductByCategory(
                  categoryId: state.allProducts[index].id ?? 0,
                  title: state.allProducts[index].translation?.title ?? "",
                  listOfProduct: state.allProducts[index].products ?? [],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
