// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/application/home/home_notifier.dart';
import 'package:shoppingapp/application/home/home_state.dart';
import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/app_bars/common_app_bar.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';

import '../../routes/app_router.dart';
import 'widgets/select_branch.dart';

class AppBarHome extends StatelessWidget {
  final HomeState state;
  final HomeNotifier event;
  final RefreshController refreshController;

  const AppBarHome(
      {super.key,
      required this.state,
      required this.event,
      required this.refreshController});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            dynamic isCheck = await context.pushRoute(ViewMapRoute());
            if (isCheck) {
              event.checkBranch(context);
              event.setAddress();
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Style.bgGrey),
                padding: EdgeInsets.all(12.r),
                child: SvgPicture.asset("assets/svgs/adress.svg"),
              ),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.deliveryAddress),
                    style: Style.interNormal(
                      size: 12,
                      color: Style.textGrey,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 60.r,
                    child: Text(
                      "${state.addressData?.title ?? ""}, ${state.addressData?.address ?? ""}",
                      style: Style.interBold(
                        size: 14,
                        color: Style.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 32.h,
          width: 1.w,
          color: Style.textGrey,
        ),
        8.horizontalSpace,
        InkWell(
          onTap: () {
            AppHelpers.showCustomModalBottomSheet(
                paddingTop: 300,
                context: context,
                modal: const SelectBranch(),
                isDarkMode: false);
            refreshController.resetNoData();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.branch),
                style: Style.interNormal(
                  size: 12,
                  color: Style.textGrey,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 70.r,
                child: !state.isBranchesLoading
                    ? Text(
                        state.branches
                                ?.firstWhere((element) {
                                  return element.id == state.selectBranchId;
                                }, orElse: () {
                                  return ShopData();
                                })
                                .translation
                                ?.title ??
                            "",
                        style: Style.interBold(
                          size: 14,
                          color: Style.black,
                        ),
                        maxLines: 1,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        const Icon(Icons.keyboard_arrow_down_sharp)
      ],
    ));
  }
}
