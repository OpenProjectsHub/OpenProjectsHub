import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shoppingapp/application/product/product_provider.dart';
import 'package:shoppingapp/application/shop_order/shop_order_provider.dart';
import 'package:shoppingapp/infrastructure/models/data/local_cart_model.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/pages/product/product_page.dart';
import 'package:shoppingapp/presentation/pages/shop/widgets/shop_product_item.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';


class ProductByCategory extends ConsumerWidget {
  final String title;
  final int categoryId;
  final List<ProductData> listOfProduct;

  const ProductByCategory({
    super.key,
    required this.title,
    required this.listOfProduct,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.verticalSpace,
        TitleAndIcon(
          title: title,
          rightTitle: AppHelpers.getTranslation(TrKeys.seeAll),
          onRightTap: () {
            context.pushRoute(
                ProductListRoute(title: title, categoryId: categoryId));
          },
        ),
        16.verticalSpace,
        SizedBox(
          height: 250.h,
          child: AnimationLimiter(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.horizontal,
              itemCount: listOfProduct.length,
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
                            data: listOfProduct[index],
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
                          product: listOfProduct[index],
                          count: LocalStorage.instance
                              .getCartLocal()
                              .firstWhere(
                                  (element) =>
                                      element.stockId ==
                                      (listOfProduct[index].stock?.id ??
                                          0), orElse: () {
                            return CartLocalModel(count: 0, stockId: 0);
                          }).count,
                          isAdd: (LocalStorage.instance
                              .getCartLocal()
                              .map((item) => item.stockId)
                              .contains(listOfProduct[index].stock?.id)),
                          addCount: () {
                            ref.read(shopOrderProvider.notifier).addCount(
                                  context: context,
                                  localIndex: LocalStorage.instance
                                      .getCartLocal()
                                      .findIndex(listOfProduct[index]
                                          .stock?.id),
                                );
                          },
                          removeCount: () {
                            ref.read(shopOrderProvider.notifier).removeCount(
                                  context: context,
                                  localIndex: LocalStorage.instance
                                      .getCartLocal()
                                      .findIndex(listOfProduct[index]
                                      .stock?.id),
                                );
                          },
                          addCart: () {
                            if (LocalStorage.instance.getToken().isNotEmpty) {
                              ref
                                  .read(shopOrderProvider.notifier)
                                  .addCart(context, listOfProduct[index]);
                              ref.read(productProvider.notifier).createCart(
                                  context, listOfProduct[index].shopId ?? 0,
                                  () {
                                ref
                                    .read(shopOrderProvider.notifier)
                                    .getCart(context, () {});
                              }, product: listOfProduct[index]);
                            } else {
                              context.pushRoute(const LoginRoute());
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
      ],
    );
  }
}
