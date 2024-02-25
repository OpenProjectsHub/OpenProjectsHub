import 'dart:async';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppingapp/application/shop/shop_provider.dart';
import 'package:shoppingapp/application/shop_order/shop_order_notifier.dart';
import 'package:shoppingapp/application/shop_order/shop_order_state.dart';
import 'package:shoppingapp/infrastructure/models/data/cart_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/loading.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/pages/shop/group_order/widgets/check_status_dialog.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../../application/shop_order/shop_order_provider.dart';
import 'widgets/cart_clear_dialog.dart';
import 'widgets/cart_order_description.dart';
import 'widgets/cart_order_item.dart';

class CartOrderPage extends ConsumerStatefulWidget {
  final bool isGroupOrder;
  final ScrollController controller;

  const CartOrderPage({
    super.key,
    this.isGroupOrder = false,
    required this.controller,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShopOrderState();
}

class _ShopOrderState extends ConsumerState<CartOrderPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    ref
        .read(shopOrderProvider.notifier)
        .getCart(context, () {}, isShowLoading: false, isStart: true);
    if (widget.isGroupOrder) {
      timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
        ref
            .read(shopOrderProvider.notifier)
            .getCart(context, () {}, isShowLoading: false);
      });
    }
  }

  @override
  void deactivate() {
    timer?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.instance.getLangLtr();
    final event = ref.read(shopOrderProvider.notifier);
    final state = ref.watch(shopOrderProvider);
    return Directionality(
        textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Style.white.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 40,
                      offset: const Offset(0, -2), // changes position of shadow
                    ),
                  ],
                  color: Style.white.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  )),
              width: double.infinity,
              child: state.cart == null ||
                      (state.cart?.userCarts?.isEmpty ?? true) ||
                      ((state.cart?.userCarts?.isEmpty ?? true)
                          ? true
                          : (state.cart?.userCarts?.first.cartDetails
                                  ?.isEmpty ??
                              true)) ||
                      LocalStorage.instance.getCartLocal().isEmpty
                  ? _resultEmpty()
                  : Stack(
                      children: [
                        ListView(
                          controller: widget.controller,
                          shrinkWrap: true,
                          children: [
                            8.verticalSpace,
                            Center(
                              child: Container(
                                height: 4.h,
                                width: 48.w,
                                decoration: BoxDecoration(
                                    color: Style.dragElement,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.r))),
                              ),
                            ),
                            18.verticalSpace,
                            state.cart?.group ?? false
                                ? _groupOrderList(state, event)
                                : Column(
                                    children: [
                                      TitleAndIcon(
                                        title: AppHelpers.getTranslation(
                                            TrKeys.yourOrder),
                                        rightTitleColor: Style.red,
                                        rightTitle: AppHelpers.getTranslation(
                                            TrKeys.clearAll),
                                        onRightTap: () {
                                          AppHelpers.showAlertDialog(
                                            context: context,
                                            child: CartClearDialog(
                                              cancel: () {
                                                Navigator.pop(context);
                                              },
                                              clear: () {
                                                ref
                                                    .read(shopOrderProvider
                                                        .notifier)
                                                    .deleteCart(context);
                                              },
                                            ),
                                            radius: 10,
                                          );
                                        },
                                      ),
                                      24.verticalSpace,
                                      ListView.builder(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.cart?.userCarts
                                                  ?.first.cartDetails?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            return CartOrderItem(
                                              add: () => event.addCount(
                                                  context: context,
                                                  localIndex: LocalStorage
                                                      .instance
                                                      .getCartLocal()
                                                      .findIndex(state
                                                          .cart
                                                          ?.userCarts
                                                          ?.first
                                                          .cartDetails?[index]
                                                          .stock
                                                          ?.id)),
                                              remove: () => event.removeCount(
                                                context: context,
                                                localIndex: LocalStorage
                                                    .instance
                                                    .getCartLocal()
                                                    .findIndex(state
                                                        .cart
                                                        ?.userCarts
                                                        ?.first
                                                        .cartDetails?[index]
                                                        .stock
                                                        ?.id),
                                              ),
                                              cart: state.cart?.userCarts?.first
                                                  .cartDetails?[index],
                                            );
                                          }),
                                    ],
                                  ),
                            bottomWidget(state, context, event)
                          ],
                        ),
                        if (state.isLoading || state.isAddAndRemoveLoading)
                          Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Style.white.withOpacity(0.4),
                              child: const Loading()),
                      ],
                    ),
            ),
          ),
        ));
  }

  ListView _groupOrderList(ShopOrderState state, ShopOrderNotifier event) {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 8.h),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.cart?.userCarts?.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const Divider(),
              Theme(
                data:
                    Theme.of(context).copyWith(dividerColor: Style.transparent),
                child: ExpansionTile(
                  title: TitleAndIcon(
                    title: state.cart?.userCarts?[index].name ?? "",
                  ),
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            state.cart?.userCarts?[index].cartDetails?.length ??
                                0,
                        itemBuilder: (context, indexCart) {
                          return CartOrderItem(
                            isOwn: index == 0,
                            add: () => event.addCount(
                                context: context,
                                localIndex: LocalStorage.instance
                                    .getCartLocal()
                                    .findIndex(state.cart?.userCarts?[index]
                                        .cartDetails?[indexCart].stock?.id)),
                            remove: () => event.removeCount(
                                context: context,
                                localIndex: LocalStorage.instance
                                    .getCartLocal()
                                    .findIndex(state.cart?.userCarts?[index]
                                        .cartDetails?[indexCart].stock?.id)),
                            cart: state.cart?.userCarts?[index]
                                .cartDetails?[indexCart],
                          );
                        })
                  ],
                ),
              ),
            ],
          );
        });
  }

  Container bottomWidget(
      ShopOrderState state, BuildContext context, ShopOrderNotifier event) {
    return Container(
      color: Style.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: 16.w,
              top: 30.h,
              left: 16.w,
            ),
            child: Column(
              children: [
                ShopOrderDescription(
                  price: ref.watch(shopProvider).shopData?.deliveryRange ?? 0,
                  svgName: "assets/svgs/delivery.svg",
                  title: AppHelpers.getTranslation(TrKeys.deliveryPrice),
                  description: AppHelpers.getTranslation(TrKeys.startPrice),
                ),
                16.verticalSpace,
                Divider(
                  color: Style.textGrey.withOpacity(0.1),
                ),
                (state.cart?.totalDiscount ?? 0) != 0
                    ? Column(
                        children: [
                          ShopOrderDescription(
                            price: state.cart?.totalDiscount ?? 0,
                            svgName: "assets/svgs/discount.svg",
                            title: AppHelpers.getTranslation(TrKeys.discount),
                            isDiscount: true,
                            description: AppHelpers.getTranslation(
                                TrKeys.youGotDiscount),
                          ),
                          16.verticalSpace,
                          Divider(
                            color: Style.textGrey.withOpacity(0.1),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          16.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.total),
                  style: Style.interNormal(
                    size: 14,
                    color: Style.black,
                  ),
                ),
                Text(
                  intl.NumberFormat.currency(
                    symbol: LocalStorage.instance.getSelectedCurrency().symbol,
                  ).format(state.cart?.totalPrice ?? 0),
                  style: Style.interSemi(
                    size: 20,
                    color: Style.black,
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 24.h,
                right: 16.w,
                left: 16.w),
            child: CustomButton(
              isLoading: state.isAddAndRemoveLoading,
              title: AppHelpers.getTranslation(TrKeys.order),
              onPressed: () {
                if (state.cart?.group ?? false) {
                  bool check = true;
                  for (UserCart cart in state.cart!.userCarts!) {
                    if (cart.status ?? true) {
                      check = true;
                      break;
                    }
                  }
                  if (check) {
                    AppHelpers.showAlertDialog(
                      context: context,
                      child: CheckStatusDialog(
                        cancel: () {
                          Navigator.pop(context);
                        },
                        onTap: () {
                          Navigator.pop(context);
                          context.pushRoute(const OrderRoute());
                        },
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                    context.pushRoute(const OrderRoute());
                  }
                } else {
                  Navigator.pop(context);
                  context.pushRoute(const OrderRoute());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _resultEmpty() {
    return Column(
      children: [
        100.verticalSpace,
        Lottie.asset('assets/lottie/girl_empty.json'),
        24.verticalSpace,
        Text(
          AppHelpers.getTranslation(TrKeys.cartIsEmpty),
          style: Style.interSemi(size: 18.sp),
        ),
      ],
    );
  }
}
