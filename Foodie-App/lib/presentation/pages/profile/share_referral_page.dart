import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/application/profile/profile_provider.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';
import 'package:shoppingapp/presentation/components/loading.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';

import '../../../infrastructure/services/local_storage.dart';
import '../../components/app_bars/common_app_bar.dart';
import '../../components/buttons/pop_button.dart';
import '../../theme/app_style.dart';

@RoutePage()
class ShareReferralPage extends ConsumerStatefulWidget {
  const ShareReferralPage({super.key});

  @override
  ConsumerState<ShareReferralPage> createState() => _ShareReferralPageState();
}

class _ShareReferralPageState extends ConsumerState<ShareReferralPage> {
  late RefreshController controller;
  final bool isLtr = LocalStorage.instance.getLangLtr();

  @override
  void initState() {
    controller = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileProvider.notifier).fetchReferral(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final event = ref.read(profileProvider.notifier);
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Style.bgGrey,
        body: Column(
          children: [
            CommonAppBar(
              child: Text(
                AppHelpers.getTranslation(TrKeys.referral),
                style: Style.interNoSemi(
                  size: 18,
                  color: Style.black,
                ),
              ),
            ),
            state.isReferralLoading
                ? const Loading()
                : Expanded(
                    child: SmartRefresher(
                      controller: controller,
                      onRefresh: () {
                        event.fetchReferral(context,
                            refreshController: controller);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200.h,
                              width: double.infinity,
                              child: CustomNetworkImage(
                                url: state.referralData?.img ?? "",
                                height: 42.r,
                                width: 42.r,
                                radius: 8.r,
                              ),
                            ),
                            Text(
                              state.referralData?.translation?.title ?? "",
                              style: Style.interNoSemi(
                                size: 20,
                                color: Style.black,
                              ),
                            ),
                            16.verticalSpace,
                            GestureDetector(
                              onTap: (){
                                context.pushRoute( ShareReferralFaqRoute(terms: state.referralData?.translation?.shortDesc ?? ""));
                              },
                              child: RichText(
                                text: TextSpan(
                                    text:
                                        "${state.referralData?.translation?.description} ",
                                    style: Style.interNoSemi(
                                      size: 14,
                                      color: Style.textGrey,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: AppHelpers.getTranslation(
                                            TrKeys.referralFaq).toLowerCase(),
                                        style: Style.interNoSemi(
                                            size: 14,
                                            color: Style.black,
                                            decoration: TextDecoration.underline),
                                      )
                                    ]),
                              ),
                            ),
                            16.verticalSpace,
                            CustomButton(
                                title: AppHelpers.getTranslation(TrKeys.share),
                                onPressed: () {
                                  FlutterShare.share(
                                      title: AppHelpers.getTranslation(
                                          TrKeys.referral),
                                      linkUrl: ref
                                              .watch(profileProvider)
                                              .userData
                                              ?.referral ??
                                          "");
                                }),
                            16.verticalSpace,
                            CustomButton(
                                background: Style.transparent,
                                borderColor: Style.black,
                                title:
                                    AppHelpers.getTranslation(TrKeys.copyCode),
                                onPressed: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: ref
                                              .watch(profileProvider)
                                              .userData
                                              ?.referral ??
                                          ""));
                                }),
                            16.verticalSpace,
                            Container(
                              height: 74.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Style.black),
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: REdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FlutterRemix.coins_fill,
                                      size: 45.r,
                                      color: Style.black,
                                    ),
                                    10.horizontalSpace,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          AppHelpers.getTranslation(
                                              TrKeys.balance),
                                          style: Style.interNormal(
                                            size: 14.sp,
                                            color: Style.black,
                                            letterSpacing: -0.3,
                                          ),
                                        ),
                                        Text(
                                          intl.NumberFormat.currency(
                                            symbol: LocalStorage.instance
                                                .getSelectedCurrency()
                                                .symbol,
                                          ).format((state.userData
                                                      ?.referralFromPrice ??
                                                  0) -
                                              (state.userData
                                                      ?.referralFromWithdrawPrice ??
                                                  0)),
                                          style: Style.interSemi(
                                            size: 18.sp,
                                            color: Style.black,
                                            letterSpacing: -0.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 1.r,
                                      height: 46.r,
                                      color: Style.black,
                                    ),
                                    const Spacer(),
                                    Text(
                                      ((state.userData?.referralFromPrice ??
                                                  0) -
                                              (state.userData
                                                      ?.referralFromWithdrawPrice ??
                                                  0))
                                          .toString(),
                                      style: Style.interSemi(
                                        size: 18.sp,
                                        color: Style.black,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const PopButton(),
        ),
      ),
    );
  }
}
