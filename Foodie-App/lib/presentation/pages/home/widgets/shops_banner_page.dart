import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppingapp/application/home/home_provider.dart';
import 'package:shoppingapp/application/product/product_provider.dart';
import 'package:shoppingapp/application/shop_order/shop_order_provider.dart';
import 'package:shoppingapp/infrastructure/models/data/local_cart_model.dart';
import 'package:shoppingapp/infrastructure/models/data/product_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/app_bars/common_app_bar.dart';
import 'package:shoppingapp/presentation/components/buttons/pop_button.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import '../../../../infrastructure/services/local_storage.dart';
import '../../../components/title_icon.dart';
import '../../../theme/app_style.dart';
import '../../product/product_page.dart';
import '../../shop/widgets/shimmer_product_list.dart';
import '../../shop/widgets/shop_product_item.dart';


@RoutePage()
class ShopsBannerPage extends ConsumerStatefulWidget {
  final int bannerId;
  final String title;

  const ShopsBannerPage({
    super.key,
    required this.bannerId,
    required this.title,
  });

  @override
  ConsumerState<ShopsBannerPage> createState() => _ShopsBannerPageState();
}

class _ShopsBannerPageState extends ConsumerState<ShopsBannerPage> {
  final bool isLtr = LocalStorage.instance.getLangLtr();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).fetchBannerById(context, widget.bannerId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(shopOrderProvider);
    final state = ref.watch(homeProvider);

    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            CommonAppBar(
              child: Text(
                widget.title,
                style: Style.interNoSemi(size: 18.sp),
                maxLines: 2,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  24.verticalSpace,
                  TitleAndIcon(
                    title: AppHelpers.getTranslation(TrKeys.products),
                  ),
                  24.verticalSpace,
                  state.isBannerLoading
                      ? const ShimmerProductList()
                      : state.banner?.products?.isEmpty ?? true
                          ? _resultEmpty()
                          : Expanded(
                            child: AnimationLimiter(
                                child: GridView.builder(
                                  padding: EdgeInsets.only(
                                      right: 12.w, left: 12.w, bottom: 96.h),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.66.r,
                                          crossAxisCount: 2,
                                          mainAxisExtent: 250.r),
                                  itemCount: state.banner?.products?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      columnCount:
                                          state.banner?.products?.length ?? 0,
                                      position: index,
                                      duration: const Duration(milliseconds: 375),
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
                                                  data: state
                                                      .banner?.products?[index],
                                                  controller: c,
                                                ),
                                                isDarkMode: false,
                                                isDrag: true,
                                                radius: 16,
                                              );
                                            },
                                            child: ShopProductItem(
                                              product:
                                                  state.banner?.products?[index],
                                          count: LocalStorage.instance
                                                .getCartLocal()
                                                .firstWhere(
                                                    (element) =>
                                                element.stockId ==
                                                    (state
                                                        .banner
                                                        ?.products?[index]
                                                        .stock?.id), orElse: () {
                                              return CartLocalModel(count: 0, stockId: 0);}).count,
                                              isAdd: (LocalStorage.instance
                                                  .getCartLocal()
                                                  .map((item) => item.stockId)
                                                  .contains(state
                                                      .banner
                                                      ?.products?[index]
                                                      .stock?.id)),
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
                                                        .banner
                                                        ?.products?[index]
                                                        .stock?.id),
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
                                                      .banner
                                                      ?.products?[index]
                                                      .stock?.id),);
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
                                                          state.banner?.products?[
                                                                  index] ??
                                                              ProductData());
                                                  ref
                                                      .read(
                                                          productProvider.notifier)
                                                      .createCart(
                                                          context,
                                                          state
                                                                  .banner
                                                                  ?.products?[index]
                                                                  .shopId ??
                                                              0, () {
                                                    ref
                                                        .read(shopOrderProvider
                                                            .notifier)
                                                        .getCart(context, () {});
                                                  },
                                                          product: state.banner
                                                              ?.products?[index]);
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
                          ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: const PopButton(),
        ),
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
