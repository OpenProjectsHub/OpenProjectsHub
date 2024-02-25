// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:like_button/like_button.dart';
import 'package:riverpodtemp/application/like/like_notifier.dart';
import 'package:riverpodtemp/application/like/like_provider.dart';
import 'package:riverpodtemp/application/product/product_notifier.dart';
import 'package:riverpodtemp/application/product/product_provider.dart';
import 'package:riverpodtemp/application/product/product_state.dart';
import 'package:riverpodtemp/application/shop/shop_provider.dart';
import 'package:riverpodtemp/application/shop_order/shop_order_notifier.dart';
import 'package:riverpodtemp/application/shop_order/shop_order_provider.dart';
import 'package:riverpodtemp/infrastructure/models/data/product_data.dart';
import 'package:riverpodtemp/infrastructure/services/app_helpers.dart';
import 'package:riverpodtemp/infrastructure/services/local_storage.dart';
import 'package:riverpodtemp/infrastructure/services/tr_keys.dart';
import 'package:riverpodtemp/presentation/components/buttons/animation_button_effect.dart';
import 'package:riverpodtemp/presentation/components/buttons/custom_button.dart';
import 'package:riverpodtemp/presentation/components/custom_network_image.dart';
import 'package:riverpodtemp/presentation/components/loading.dart';
import 'package:riverpodtemp/presentation/components/title_icon.dart';
import 'package:riverpodtemp/presentation/pages/product/widgets/w_ingredient.dart';
import 'package:riverpodtemp/presentation/theme/theme.dart';
import '../shop/widgets/bonus_screen.dart';
import 'widgets/p_main_button.dart';
import 'widgets/w_product_extras.dart';

class ProductScreen extends ConsumerStatefulWidget {
  final ProductData? data;
  final String? productId;
  final ScrollController? controller;

  const ProductScreen({
    this.productId,
    this.data,
    this.controller,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  late bool isLtr;
  late ProductNotifier event;
  late LikeNotifier eventLike;
  late ShopOrderNotifier eventOrderShop;

  @override
  void initState() {
    ref.refresh(productProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.productId != null) {
        ref.read(productProvider.notifier).getProductDetailsById(
            context,
            widget.productId ?? "",
            ref.watch(shopProvider).shopData?.type,
            ref.watch(shopProvider).shopData?.id);
      } else {
        ref.read(productProvider.notifier).getProductDetails(
            context,
            widget.data!,
            ref.watch(shopProvider).shopData?.type,
            ref.watch(shopProvider).shopData?.id);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    isLtr = LocalStorage.instance.getLangLtr();
    event = ref.read(productProvider.notifier);
    eventLike = ref.read(likeProvider.notifier);
    eventOrderShop = ref.read(shopOrderProvider.notifier);
    super.didChangeDependencies();
  }

  void checkShopOrder(
      {required ProductNotifier event,
      required ProductState state,
      required ShopOrderNotifier eventOrderShop}) {
    AppHelpers.showAlertDialog(
        context: context,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppHelpers.getTranslation(TrKeys.allPreviouslyAdded),
              style: Style.interNormal(),
              textAlign: TextAlign.center,
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                      title: AppHelpers.getTranslation(TrKeys.cancel),
                      background: Style.transparent,
                      borderColor: Style.borderColor,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                10.horizontalSpace,
                Expanded(child: Consumer(builder: (contextTwo, ref, child) {
                  return CustomButton(
                      isLoading: ref.watch(shopOrderProvider).isDeleteLoading,
                      title: AppHelpers.getTranslation(TrKeys.continueText),
                      onPressed: () {
                        eventOrderShop.deleteCart(context).then((value) async {
                          event.createCart(
                              context,
                              ref.watch(shopOrderProvider).cart?.shopId ??
                                  (state.productData!.shopId ?? 0), () {
                            eventOrderShop.getCart(context, () {});
                            Navigator.pop(context);
                          });
                        });
                      });
                })),
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);
    final stateOrderShop = ref.watch(shopOrderProvider);
    ref.listen(productProvider, (previous, next) {
      if (next.isCheckShopOrder &&
          (next.isCheckShopOrder != (previous?.isCheckShopOrder ?? false))) {
        checkShopOrder(
            event: event, state: state, eventOrderShop: eventOrderShop);
      }
    });
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            color: Style.bgGrey.withOpacity(0.96),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            )),
        width: double.infinity,
        child: state.isLoading
            ? const Loading()
            : SingleChildScrollView(
          controller: widget.controller,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.verticalSpace,
                          Center(
                            child: Container(
                              height: 4.h,
                              width: 48.w,
                              decoration: BoxDecoration(
                                  color: Style.dragElement,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.r))),
                            ),
                          ),
                          14.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: TitleAndIcon(
                                  title:
                                      state.productData?.translation?.title ??
                                          "",
                                  paddingHorizontalSize: 0,
                                ),
                              ),
                              8.horizontalSpace,
                              Container(
                                  width: 44.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Style.black),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  padding:
                                      EdgeInsets.only(left: 6.r, right: 4.r),
                                  child: LikeButton(
                                    isLiked: state.isLike,
                                    padding: EdgeInsets.zero,
                                    likeBuilder: (isLike) {
                                      return Icon(
                                        !isLike
                                            ? FlutterRemix.heart_3_line
                                            : FlutterRemix.heart_3_fill,
                                        color:
                                            isLike ? Style.red : Style.black,
                                        size: 26.r,
                                      );
                                    },
                                    onTap: (s){
                                      return Future(() {
                                        event.onLike();
                                        eventLike.fetchLikeProducts(context);
                                        return !s;
                                      });

                                    },
                                  )),
                              8.horizontalSpace,
                              GestureDetector(
                                onTap: () => event.shareProduct(),
                                child: Container(
                                  width: 40.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                      color: Style.transparent,
                                      border: Border.all(color: Style.black),
                                      borderRadius: BorderRadius.circular(8.r)),
                                  child: const Center(
                                      child: Icon(FlutterRemix.share_line)),
                                ),
                              )
                            ],
                          ),
                          20.verticalSpace,
                          CustomNetworkImage(
                              url: state.productData?.img ?? "",
                              height: 200.h,
                              width: double.infinity,
                              radius: 10.r),
                          state.selectedStock?.bonus != null
                              ? Padding(
                                  padding: EdgeInsets.only(top: 12.h),
                                  child: Row(
                                    children: [
                                      AnimationButtonEffect(
                                        child: InkWell(
                                          onTap: () {
                                            AppHelpers
                                                .showCustomModalBottomSheet(
                                              context: context,
                                              modal: BonusScreen(
                                                bonus:
                                                    state.selectedStock?.bonus,
                                              ),
                                              isDarkMode: false,
                                              isDrag: true,
                                              radius: 12,
                                            );
                                          },
                                          child: Container(
                                            width: 22.w,
                                            height: 22.h,
                                            margin: EdgeInsets.all(8.r),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Style.blueBonus),
                                            child: Icon(
                                              FlutterRemix.gift_2_fill,
                                              size: 16.r,
                                              color: Style.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      4.horizontalSpace,
                                      Text(
                                        ((state.selectedStock?.bonus?.type ??
                                                    "sum") ==
                                                "sum")
                                            ? "${AppHelpers.getTranslation(TrKeys.under)} ${intl.NumberFormat.currency(
                                                symbol: LocalStorage.instance
                                                    .getSelectedCurrency()
                                                    .symbol,
                                              ).format(state.selectedStock?.bonus?.value ?? 0)} + ${state.selectedStock?.bonus?.bonusStock?.product?.translation?.title ?? ""}"
                                            : "${AppHelpers.getTranslation(TrKeys.under)} ${state.selectedStock?.bonus?.value ?? 0} + ${state.selectedStock?.bonus?.bonusStock?.product?.translation?.title ?? ""}",
                                        style: Style.interRegular(
                                          size: 14,
                                          color: Style.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                          15.verticalSpace,
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    state.productData?.translation
                                            ?.description ??
                                        "",
                                    style: Style.interRegular(
                                      size: 14.sp,
                                      color: Style.textGrey,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      intl.NumberFormat.currency(
                                        symbol: LocalStorage.instance
                                            .getSelectedCurrency()
                                            .symbol,
                                      ).format(
                                          (state.selectedStock?.price ?? 0) +
                                              (state.selectedStock?.tax ?? 0)),
                                      style: Style.interRegular(
                                          size: 14.sp,
                                          color: Style.black,
                                          textDecoration:
                                              state.selectedStock?.discount ==
                                                      null
                                                  ? TextDecoration.none
                                                  : TextDecoration.lineThrough),
                                    ),
                                    state.selectedStock?.discount == null
                                        ? const SizedBox.shrink()
                                        : Container(
                                            margin: EdgeInsets.only(top: 8.r),
                                            decoration: BoxDecoration(
                                                color: Style.redBg,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.r)),
                                            padding: EdgeInsets.all(4.r),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/svgs/discount.svg"),
                                                8.horizontalSpace,
                                                Text(
                                                  intl.NumberFormat.currency(
                                                    symbol: LocalStorage
                                                        .instance
                                                        .getSelectedCurrency()
                                                        .symbol,
                                                  ).format((state.selectedStock
                                                          ?.totalPrice ??
                                                      0)),
                                                  style: Style.interNoSemi(
                                                      size: 12,
                                                      color: Style.red),
                                                )
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          24.verticalSpace,
                          const WProductExtras(),
                          24.verticalSpace,
                          WIngredientScreen(
                            list: state.selectedStock?.addons ?? [],
                            onChange: (int value) {
                              event.updateIngredient(context, value);
                            },
                            add: (int value) {
                              event.addIngredient(context, value);
                            },
                            remove: (int value) {
                              event.removeIngredient(context, value);
                            },
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    ProductMainButton(
                      state: state,
                      event: event,
                      stateOrderShop: stateOrderShop,
                      eventOrderShop: eventOrderShop,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
