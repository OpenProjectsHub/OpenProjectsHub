import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:shoppingapp/application/shop_order/shop_order_provider.dart';
import 'package:shoppingapp/infrastructure/models/data/cart_data.dart';
import 'package:shoppingapp/infrastructure/services/app_constants.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:flutter/services.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

import 'widgets/check_status_dialog.dart';
import 'widgets/group_item.dart';


class GroupOrderScreen extends ConsumerStatefulWidget {
  const GroupOrderScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupOrderPageState();
}

class _GroupOrderPageState extends ConsumerState<GroupOrderScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    ref
        .read(shopOrderProvider.notifier)
        .getCart(context, () {}, isShowLoading: false);
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      ref
          .read(shopOrderProvider.notifier)
          .getCart(context, () {}, isShowLoading: false);
    });
  }

  @override
  void deactivate() {
    timer?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.instance.getLangLtr();
    final state = ref.watch(shopOrderProvider);
    final event = ref.read(shopOrderProvider.notifier);
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
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
                        borderRadius: BorderRadius.all(Radius.circular(40.r))),
                  ),
                ),
                14.verticalSpace,
                TitleAndIcon(
                  title: AppHelpers.getTranslation(TrKeys.startGroupOrder),
                  paddingHorizontalSize: 0,
                ),
                10.verticalSpace,
                Text(
                  AppHelpers.getTranslation(TrKeys.youFullyManaga),
                  style: Style.interRegular(
                    size: 14,
                    color: Style.textGrey,
                  ),
                ),
                30.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 220.w,
                      height: 46.h,
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Style.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        boxShadow: [
                          BoxShadow(
                            color: Style.black.withOpacity(0.04),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Text(
                        "${AppConstants.webUrl}/restaurant/${state.cart?.shopId}?g=${state.cart?.id}",
                        style: Style.interRegular(
                          size: 14,
                          color: Style.textGrey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        AppHelpers.showCheckTopSnackBarDone(
                            context, AppHelpers.getTranslation(TrKeys.coped));
                        await Clipboard.setData(ClipboardData(
                            text:
                                "${AppConstants.webUrl}/restaurant/${state.cart?.shopId}?g=${state.cart?.id}"));
                      },
                      child: Container(
                          width: 46.w,
                          height: 46.h,
                          decoration: BoxDecoration(
                            color: Style.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            boxShadow: [
                              BoxShadow(
                                color: Style.black.withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Icon(FlutterRemix.file_copy_fill)),
                    ),
                    GestureDetector(
                      onTap: () {
                        FlutterShare.share(
                            title: AppHelpers.getTranslation(
                                TrKeys.groupOrderProgress),
                            linkUrl:
                                "${AppConstants.webUrl}/restaurant/${state.cart?.shopId}?g=${state.cart?.id}");
                      },
                      child: Container(
                          width: 46.w,
                          height: 46.h,
                          decoration: BoxDecoration(
                            color: Style.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            boxShadow: [
                              BoxShadow(
                                color: Style.black.withOpacity(0.04),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Icon(FlutterRemix.share_fill)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    20.verticalSpace,
                    TitleAndIcon(
                      title: AppHelpers.getTranslation(TrKeys.groupMember),
                      paddingHorizontalSize: 0,
                      titleSize: 14,
                    ),
                    8.verticalSpace,
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.cart?.userCarts?.length ?? 0,
                        itemBuilder: (context, index) {
                          List<CartDetail?>? list =
                              state.cart?.userCarts?[index].cartDetails;
                          num total = 0;
                          list?.forEach((element) {
                            total += element?.price ?? 0;
                          });
                          return GroupItem(
                            name: state.cart?.userCarts?[index].name ?? "",
                            price: total,
                            isChoosing:
                                state.cart?.userCarts?[index].status ?? false,
                            onDelete: () {
                              ref
                                  .read(shopOrderProvider.notifier)
                                  .deleteUser(context, index);
                            },
                            isDeleteButton: index != 0,
                          );
                        }),
                  ],
                ),
                24.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 16.h,
                  ),
                  child: CustomButton(
                    title: AppHelpers.getTranslation(TrKeys.order),
                    onPressed: () {
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
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 16.h,
                  ),
                  child: CustomButton(
                    title: AppHelpers.getTranslation(TrKeys.cancel),
                    borderColor: Style.black,
                    background: Style.transparent,
                    onPressed: () {
                      event.deleteCart(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
