import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpodtemp/application/order/order_provider.dart';
import 'package:riverpodtemp/application/shop_order/shop_order_provider.dart';
import 'package:riverpodtemp/infrastructure/services/app_constants.dart';
import 'package:riverpodtemp/infrastructure/services/app_helpers.dart';
import 'package:riverpodtemp/infrastructure/services/local_storage.dart';
import 'package:riverpodtemp/infrastructure/services/tpying_delay.dart';
import 'package:riverpodtemp/infrastructure/services/tr_keys.dart';
import 'package:riverpodtemp/presentation/components/title_icon.dart';
import 'package:riverpodtemp/presentation/pages/shop/cart/widgets/cart_clear_dialog.dart';
import 'package:riverpodtemp/presentation/pages/shop/cart/widgets/cart_order_item.dart';
import 'package:riverpodtemp/presentation/theme/app_style.dart';

class OrderCarts extends StatefulWidget {
  final double lat;
  final double long;
  final int tabBarIndex;

  const OrderCarts(
      {super.key,
      required this.lat,
      required this.long,
      required this.tabBarIndex});

  @override
  State<OrderCarts> createState() => _OrderCartsState();
}

class _OrderCartsState extends State<OrderCarts> {
  final _delayed = Delayed(milliseconds: 1200);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final stateCart = ref.watch(shopOrderProvider).cart;
      final state = ref.watch(orderProvider);
      return (stateCart?.group ?? false)
          ? ref.watch(orderProvider).orderData == null
              ? ListView.builder(
                  padding: EdgeInsets.only(bottom: 8.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: stateCart?.userCarts?.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const Divider(),
                        Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Style.transparent),
                          child: ExpansionTile(
                            title: TitleAndIcon(
                              title:
                                  " ${stateCart?.userCarts?[index].name ?? ""} ${index == 0 ? "(${AppHelpers.getTranslation(TrKeys.owner)})" : ""}",
                            ),
                            children: [
                              ListView.builder(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: stateCart?.userCarts?[index]
                                          .cartDetails?.length ??
                                      0,
                                  itemBuilder: (context, indexCart) {
                                    return CartOrderItem(
                                      isOwn: index == 0,
                                      add: () {
                                        ref
                                            .read(shopOrderProvider.notifier)
                                            .addCount(
                                              context: context,
                                              localIndex: LocalStorage.instance
                                                  .getCartLocal()
                                                  .findIndex(stateCart
                                                      ?.userCarts?[index]
                                                      .cartDetails?[indexCart]
                                                      .stock
                                                      ?.id),
                                            )
                                            .then((value) {
                                          _delayed.run(() {
                                            ref
                                                .read(orderProvider.notifier)
                                                .getCalculate(
                                                    isLoading: false,
                                                    context: context,
                                                    cartId: stateCart?.id ?? 0,
                                                    long: widget.long,
                                                    lat: widget.lat,
                                                    type:
                                                        widget.tabBarIndex == 0
                                                            ? DeliveryTypeEnum
                                                                .delivery
                                                            : DeliveryTypeEnum
                                                                .pickup);
                                          });
                                        });
                                      },
                                      remove: () {
                                        ref
                                            .read(shopOrderProvider.notifier)
                                            .removeCount(
                                              context: context,
                                              localIndex: LocalStorage.instance
                                                  .getCartLocal()
                                                  .findIndex(stateCart
                                                      ?.userCarts?[index]
                                                      .cartDetails?[indexCart]
                                                      .stock
                                                      ?.id),
                                            )
                                            .then((value) {
                                          _delayed.run(() {
                                            ref
                                                .read(orderProvider.notifier)
                                                .getCalculate(
                                                  isLoading: false,
                                                  context: context,
                                                  cartId: stateCart?.id ?? 0,
                                                  long: widget.long,
                                                  lat: widget.lat,
                                                  type: widget.tabBarIndex == 0
                                                      ? DeliveryTypeEnum
                                                          .delivery
                                                      : DeliveryTypeEnum.pickup,
                                                );
                                          });
                                        });
                                      },
                                      cart: stateCart?.userCarts?[index]
                                          .cartDetails?[indexCart],
                                    );
                                  })
                            ],
                          ),
                        ),
                      ],
                    );
                  })
              : ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.orderData?.details?.length ?? 0,
                  itemBuilder: (context, index) {
                    return CartOrderItem(
                      isActive: false,
                      add: () {},
                      remove: () {},
                      cartTwo: state.orderData?.details?[index],
                      cart: null,
                    );
                  })
          : ref.watch(orderProvider).orderData == null
              ? Column(
                  children: [
                    24.verticalSpace,
                    TitleAndIcon(
                      title: state.orderData != null
                          ? AppHelpers.getTranslation(TrKeys.compositionOrder)
                          : AppHelpers.getTranslation(TrKeys.yourOrder),
                      rightTitleColor: Style.red,
                      rightTitle: state.orderData == null
                          ? AppHelpers.getTranslation(TrKeys.clear)
                          : null,
                      onRightTap: state.orderData == null
                          ? () {
                              AppHelpers.showAlertDialog(
                                context: context,
                                child: CartClearDialog(
                                  isLoading: ref
                                      .watch(shopOrderProvider)
                                      .isDeleteLoading,
                                  cancel: () {
                                    Navigator.pop(context);
                                  },
                                  clear: () {
                                    ref
                                        .read(shopOrderProvider.notifier)
                                        .deleteCart(context);
                                    context.popRoute();
                                  },
                                ),
                                radius: 10,
                              );
                            }
                          : null,
                    ),
                    ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 14.h),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            stateCart?.userCarts?.first.cartDetails?.length ??
                                0,
                        itemBuilder: (context, index) {
                          return CartOrderItem(
                            add: () {
                              ref
                                  .read(shopOrderProvider.notifier)
                                  .addCount(
                                    context: context,
                                    localIndex:  LocalStorage
                                        .instance
                                        .getCartLocal()
                                        .findIndex( stateCart?.userCarts?.first
                                        .cartDetails?[index].stock?.id),
                                  )
                                  .then((value) {
                                _delayed.run(() {
                                  ref.read(orderProvider.notifier).getCalculate(
                                      isLoading: false,
                                      context: context,
                                      cartId: stateCart?.id ?? 0,
                                      long: widget.long,
                                      lat: widget.lat,
                                      type: widget.tabBarIndex == 0
                                          ? DeliveryTypeEnum.delivery
                                          : DeliveryTypeEnum.pickup);
                                });
                              });
                            },
                            remove: () {
                              ref
                                  .read(shopOrderProvider.notifier)
                                  .removeCount(
                                    context: context,
                                  localIndex:  LocalStorage
                                      .instance
                                      .getCartLocal()
                                      .findIndex( stateCart?.userCarts?.first
                                      .cartDetails?[index].stock?.id)
                                  )
                                  .then((value) {
                                _delayed.run(() {
                                  ref.read(orderProvider.notifier).getCalculate(
                                        isLoading: false,
                                        context: context,
                                        cartId: stateCart?.id ?? 0,
                                        long: widget.long,
                                        lat: widget.lat,
                                        type: widget.tabBarIndex == 0
                                            ? DeliveryTypeEnum.delivery
                                            : DeliveryTypeEnum.pickup,
                                      );
                                });
                              });
                            },
                            cart:
                                stateCart?.userCarts?.first.cartDetails?[index],
                          );
                        }),
                  ],
                )
              : ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      ref.watch(orderProvider).orderData?.details?.length ?? 0,
                  itemBuilder: (context, index) {
                    return CartOrderItem(
                      isActive: false,
                      add: () {},
                      remove: () {},
                      cartTwo:
                          ref.watch(orderProvider).orderData?.details?[index],
                      cart: null,
                    );
                  });
    });
  }
}
