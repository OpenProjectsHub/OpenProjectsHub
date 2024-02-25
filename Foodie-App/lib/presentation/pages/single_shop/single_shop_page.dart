import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/application/like/like_notifier.dart';
import 'package:shoppingapp/application/main/main_provider.dart';
import 'package:shoppingapp/application/shop/shop_notifier.dart';
import 'package:shoppingapp/application/shop/shop_provider.dart';
import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/app_bars/common_app_bar.dart';
import 'package:shoppingapp/presentation/components/loading.dart';
import 'package:shoppingapp/presentation/pages/shop/widgets/shop_page_avatar.dart';
import 'package:shoppingapp/presentation/pages/single_shop/widgets/info_screen.dart';
import 'package:shoppingapp/presentation/pages/single_shop/widgets/review_screen.dart';

import '../../../application/like/like_provider.dart';
import '../../theme/app_style.dart';
import 'widgets/order_food.dart';

@RoutePage()
class SingleShopPage extends ConsumerStatefulWidget {
  const SingleShopPage({super.key});

  @override
  ConsumerState<SingleShopPage> createState() => _SingleShopPageState();
}

class _SingleShopPageState extends ConsumerState<SingleShopPage> {
  late ShopNotifier event;
  late LikeNotifier eventLike;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shopProvider.notifier).fetchShopMain(context);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    event = ref.read(shopProvider.notifier);
    eventLike = ref.read(likeProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shopProvider);
    return Scaffold(
      backgroundColor: Style.bgGrey,
      body: Column(
        children: [
          CommonAppBar(
            child: Text(
              AppHelpers.getTranslation(TrKeys.shopInfo),
              style: Style.interNoSemi(
                size: 18,
                color: Style.black,
              ),
            ),
          ),
          state.isLoading
              ? Padding(
                  padding: EdgeInsets.only(top: 64.r),
                  child: const Loading(),
                )
              : Expanded(
                  child: SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: () {
                      event.fetchShopMain(context,
                          isRefresh: true,
                          refreshController: _refreshController);
                    },
                    onLoading: () {
                      event.fetchReviewPage(context, _refreshController);
                    },
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 48.r),
                        child: Column(
                          children: [
                            4.verticalSpace,
                            ShopPageAvatar(
                              workTime: state.endTodayTime.hour >
                                      TimeOfDay.now().hour
                                  ? "${state.startTodayTime.hour.toString().padLeft(2, '0')}:${state.startTodayTime.minute.toString().padLeft(2, '0')} - ${state.endTodayTime.hour.toString().padLeft(2, '0')}:${state.endTodayTime.minute.toString().padLeft(2, '0')}"
                                  : AppHelpers.getTranslation(TrKeys.close),
                              onLike: () {
                                event.onLike();
                                eventLike.fetchLikeProducts(context);
                              },
                              isLike: state.isLike,
                              shop: state.shopData ?? ShopData(),
                              onShare: event.onShare,
                              bonus: state.shopData?.bonus,
                            ),
                            10.verticalSpace,
                            InfoScreen(
                                shop: state.shopData,
                                endTodayTime: state.endTodayTime,
                                startTodayTime: state.startTodayTime,
                                shopMarker: state.shopMarkers),
                            20.verticalSpace,
                            OrderFoodScreen(
                              shop: state.shopData,
                              startOrder: () {
                                ref.read(mainProvider.notifier).selectIndex(0);
                              },
                            ),
                            20.verticalSpace,
                            ReviewScreen(
                              shop: state.shopData,
                              review: state.reviews,
                              reviewCount: state.reviewCount,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
