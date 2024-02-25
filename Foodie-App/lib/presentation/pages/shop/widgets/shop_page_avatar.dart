import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppingapp/application/shop/shop_provider.dart';
import 'package:shoppingapp/application/shop_order/shop_order_provider.dart';
import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/animation_button_effect.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';
import 'package:shoppingapp/presentation/components/shop_avarat.dart';
import 'package:shoppingapp/presentation/pages/shop/group_order/group_order.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

import '../../../../infrastructure/models/data/bonus_data.dart';
import '../../../components/bonus_discount_popular.dart';
import 'bonus_screen.dart';
import 'shop_description_item.dart';
import 'package:intl/intl.dart' as intl;

class ShopPageAvatar extends StatelessWidget {
  final ShopData shop;
  final String workTime;
  final bool isLike;
  final VoidCallback onShare;
  final VoidCallback onLike;
  final BonusModel? bonus;

  const ShopPageAvatar(
      {super.key,
      required this.shop,
      required this.onLike,
      required this.workTime,
      required this.isLike,
      required this.onShare,
      required this.bonus});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        shopAppBar(context),
        8.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shop.translation?.title ?? "",
                style: Style.interSemi(
                  size: 22,
                  color: Style.black,
                ),
              ),
              Text(
                shop.translation?.description ?? "",
                style: Style.interNormal(
                  size: 13,
                  color: Style.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              6.verticalSpace,
              Row(
                children: [
                  SvgPicture.asset("assets/svgs/star.svg"),
                  4.horizontalSpace,
                  Text(
                    (shop.avgRate ?? ""),
                    style: Style.interNormal(
                      size: 12.sp,
                      color: Style.black,
                    ),
                  ),
                  8.horizontalSpace,
                  BonusDiscountPopular(
                    isSingleShop: true,
                    isPopular: shop.isRecommend ?? false,
                    bonus: shop.bonus,
                    isDiscount: shop.isDiscount ?? false,
                  ),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShopDescriptionItem(
                    title: AppHelpers.getTranslation(TrKeys.workingHours),
                    description: workTime,
                    icon: const Icon(FlutterRemix.time_fill),
                  ),
                  ShopDescriptionItem(
                    title: AppHelpers.getTranslation(TrKeys.deliveryTime),
                    description:
                        "${shop.deliveryTime?.from ?? 0} - ${shop.deliveryTime?.to ?? 0} ${shop.deliveryTime?.type ?? "min"}",
                    icon: SvgPicture.asset("assets/svgs/delivery.svg"),
                  ),
                  ShopDescriptionItem(
                    title: AppHelpers.getTranslation(TrKeys.deliveryPrice),
                    description:
                        "${AppHelpers.getTranslation(TrKeys.from)} ${intl.NumberFormat.currency(
                      symbol:
                          LocalStorage.instance.getSelectedCurrency().symbol,
                    ).format(shop.deliveryRange ?? 0)}",
                    icon: SvgPicture.asset(
                      "assets/svgs/ticket.svg",
                      width: 18.r,
                      height: 18.r,
                    ),
                  ),
                ],
              ),
              AppHelpers.getTranslation(TrKeys.close) == workTime
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 32,
                        decoration: BoxDecoration(
                            color: Style.bgGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                        padding: const EdgeInsets.all(6),
                        child: Row(
                          children: [
                            const Icon(
                              FlutterRemix.time_fill,
                              color: Style.black,
                            ),
                            8.horizontalSpace,
                            Expanded(
                              child: Text(
                                AppHelpers.getTranslation(
                                    TrKeys.notWorkTodayTime),
                                style: Style.interNormal(
                                  size: 14,
                                  color: Style.black,
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              bonus != null ? _bonusButton(context) : const SizedBox.shrink(),
              12.verticalSpace,
              // groupOrderButton(context),
            ],
          ),
        )
      ],
    );
  }

  checkOtherShop(BuildContext context) {
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
                        ref
                            .read(shopOrderProvider.notifier)
                            .deleteCart(context)
                            .then((value) async {
                          ref.read(shopOrderProvider.notifier).createCart(
                                context,
                                (shop.id ?? 0),
                              );
                        });
                      });
                })),
              ],
            )
          ],
        ));
  }

  Widget groupOrderButton(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      ref.listen(shopOrderProvider, (previous, next) {
        if (next.isOtherShop && next.isOtherShop != previous?.isOtherShop) {
          checkOtherShop(context);
        }
        if (next.isStartGroup && next.isStartGroup != previous?.isStartGroup) {
          AppHelpers.showCustomModalBottomSheet(
            paddingTop: MediaQuery.of(context).padding.top + 160.h,
            context: context,
            modal: const GroupOrderScreen(),
            isDarkMode: false,
            isDrag: true,
            radius: 12,
          );
        }
      });
      bool isStartOrder = (ref.watch(shopOrderProvider).cart?.group ?? false) &&
          (ref.watch(shopOrderProvider).cart?.shopId == shop.id);
      return CustomButton(
        isLoading: ref.watch(shopOrderProvider).isStartGroupLoading ||
            ref.watch(shopOrderProvider).isCheckShopOrder,
        icon: Icon(
          isStartOrder
              ? FlutterRemix.list_settings_line
              : FlutterRemix.group_2_line,
          color: isStartOrder ? Style.black : Style.white,
        ),
        title: isStartOrder
            ? AppHelpers.getTranslation(TrKeys.manageOrder)
            : AppHelpers.getTranslation(TrKeys.startGroupOrder),
        background: isStartOrder ? Style.brandGreen : Style.orderButtonColor,
        textColor: isStartOrder ? Style.black : Style.white,
        radius: 10,
        onPressed: () {
          if (LocalStorage.instance.getToken().isNotEmpty) {
            !isStartOrder
                ? ref.read(shopOrderProvider.notifier).createCart(
                      context,
                      shop.id ?? 0,
                    )
                : AppHelpers.showCustomModalBottomSheet(
                    paddingTop: MediaQuery.of(context).padding.top + 160.h,
                    context: context,
                    modal: const GroupOrderScreen(),
                    isDarkMode: false,
                    isDrag: true,
                    radius: 12,
                  );
          } else {
            context.pushRoute(const LoginRoute());
          }
        },
      );
    });
  }

  Stack shopAppBar(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 180.h + MediaQuery.of(context).padding.top,
          width: double.infinity,
          color: Style.mainBack,
          child: CustomNetworkImage(
            url: shop.backgroundImg ?? "",
            height: 180.h + MediaQuery.of(context).padding.top,
            width: double.infinity,
            radius: 0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 130.h + MediaQuery.of(context).padding.top,
              left: 16.w,
              right: 16.w),
          child: ShopAvatar(
            radius: 20,
            shopImage: shop.logoImg ?? "",
            size: 70,
            padding: 6,
            bgColor: Style.white.withOpacity(0.65),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top,
          right: 16.w,
          child: Row(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return GestureDetector(
                    onTap: () {
                      context.pushRoute(AllGalleriesRoute(
                          galleriesModel: ref.watch(shopProvider).galleries));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.r, horizontal: 12.r),
                          color:
                              Style.unselectedBottomBarItem.withOpacity(0.29),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/svgs/menuS.svg"),
                              6.horizontalSpace,
                              Text(AppHelpers.getTranslation(
                                  TrKeys.seeAllPhotos))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  AnimationButtonEffect _bonusButton(BuildContext context) {
    return AnimationButtonEffect(
      child: GestureDetector(
          onTap: () {
            AppHelpers.showCustomModalBottomSheet(
              paddingTop: MediaQuery.of(context).padding.top,
              context: context,
              modal: BonusScreen(
                bonus: bonus,
              ),
              isDarkMode: false,
              isDrag: true,
              radius: 12,
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 8.h),
            width: MediaQuery.of(context).size.width - 32,
            decoration: BoxDecoration(
                color: Style.bgGrey,
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
            padding: const EdgeInsets.all(6),
            child: Row(
              children: [
                Container(
                  width: 22.w,
                  height: 22.h,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Style.blueBonus),
                  child: Icon(
                    FlutterRemix.gift_2_fill,
                    size: 16.r,
                    color: Style.white,
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: Text(
                    bonus != null
                        ? ((bonus?.type ?? "sum") == "sum")
                            ? "${AppHelpers.getTranslation(TrKeys.under)} ${intl.NumberFormat.currency(
                                symbol: LocalStorage.instance
                                    .getSelectedCurrency()
                                    .symbol,
                              ).format(bonus?.value ?? 0)} + ${bonus?.bonusStock?.product?.translation?.title ?? ""}"
                            : "${AppHelpers.getTranslation(TrKeys.under)} ${bonus?.value ?? 0} + ${bonus?.bonusStock?.product?.translation?.title ?? ""}"
                        : "",
                    style: Style.interNormal(
                      size: 14,
                      color: Style.black,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
