import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/application/orders_list/orders_list_notifier.dart';
import 'package:shoppingapp/application/orders_list/orders_list_provider.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/app_bars/common_app_bar.dart';
import 'package:shoppingapp/presentation/components/buttons/pop_button.dart';
import 'package:shoppingapp/presentation/components/custom_tab_bar.dart';
import 'package:shoppingapp/presentation/components/loading.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';
import 'widgets/orders_item.dart';

@RoutePage()
class OrdersListPage extends ConsumerStatefulWidget {
  const OrdersListPage({super.key});

  @override
  ConsumerState<OrdersListPage> createState() => _OrdersListPage();
}

class _OrdersListPage extends ConsumerState<OrdersListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late RefreshController activeRefreshController;
  late RefreshController historyRefreshController;
  late RefreshController refundRefreshController;
  late OrdersListNotifier event;

  final _tabs = [
    Tab(text: AppHelpers.getTranslation(TrKeys.activeOrders)),
    Tab(text: AppHelpers.getTranslation(TrKeys.orderHistory)),
    Tab(text: AppHelpers.getTranslation(TrKeys.reFound)),
  ];

  @override
  void initState() {
    activeRefreshController = RefreshController();
    historyRefreshController = RefreshController();
    refundRefreshController = RefreshController();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ordersListProvider.notifier).fetchActiveOrders(context);
      ref.read(ordersListProvider.notifier).fetchHistoryOrders(context);
      ref.read(ordersListProvider.notifier).fetchRefundOrders(context);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    event = ref.read(ordersListProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    activeRefreshController.dispose();
    historyRefreshController.dispose();
    refundRefreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = LocalStorage.instance.getAppThemeMode();
    final bool isLtr = LocalStorage.instance.getLangLtr();
    final state = ref.watch(ordersListProvider);
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: isDarkMode ? Style.mainBackDark : Style.bgGrey,
        body: Column(
          children: [
            CommonAppBar(
              child: Text(
                AppHelpers.getTranslation(TrKeys.order),
                style: Style.interNoSemi(
                  size: 18,
                  color: Style.black,
                ),
              ),
            ),
            16.verticalSpace,
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    CustomTabBar(
                      isScrollable: true,
                      tabController: _tabController,
                      tabs: _tabs,
                    ),
                    Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        state.isActiveLoading
                            ? const Loading()
                            : SmartRefresher(
                                controller: activeRefreshController,
                                enablePullDown: true,
                                enablePullUp: true,
                                onRefresh: () {
                                  event.fetchActiveOrdersPage(
                                      context, activeRefreshController,
                                      isRefresh: true);
                                  activeRefreshController.refreshCompleted();
                                },
                                onLoading: () {
                                  event.fetchActiveOrdersPage(
                                      context, activeRefreshController);
                                },
                                child: state.activeOrders.isNotEmpty ? ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: 24.h),
                                  itemCount: state.activeOrders.length,
                                  itemBuilder: (context, index) {
                                    return OrdersItem(
                                      order: state.activeOrders[index],
                                      isActive: true,
                                    );
                                  },
                                ) : _resultEmpty(),
                              ),
                        state.isHistoryLoading
                            ? const Loading()
                            : SmartRefresher(
                                controller: historyRefreshController,
                                enablePullDown: true,
                                enablePullUp: true,
                                onRefresh: () {
                                  event.fetchHistoryOrdersPage(
                                      context, historyRefreshController,
                                      isRefresh: true);
                                  historyRefreshController.refreshCompleted();
                                },
                                onLoading: () {
                                  event.fetchHistoryOrdersPage(
                                      context, historyRefreshController);
                                },
                                child: ListView.builder(
                                  padding: EdgeInsets.only(top: 24.h),
                                  itemCount: state.historyOrders.length,
                                  itemBuilder: (context, index) {
                                    return OrdersItem(
                                      order: state.historyOrders[index],
                                      isActive: false,
                                    );
                                  },
                                ),
                              ),
                        state.isRefundLoading
                            ? const Loading()
                            : SmartRefresher(
                                controller: refundRefreshController,
                                enablePullDown: true,
                                enablePullUp: true,
                                onRefresh: () {
                                  event.fetchRefundOrdersPage(
                                      context, refundRefreshController,
                                      isRefresh: true);
                                  refundRefreshController.refreshCompleted();
                                },
                                onLoading: () {
                                  event.fetchRefundOrdersPage(
                                      context, refundRefreshController);
                                },
                                child: ListView.builder(
                                  padding: EdgeInsets.only(top: 24.h),
                                  itemCount: state.refundOrders.length,
                                  itemBuilder: (context, index) {
                                    return OrdersItem(
                                      isRefund: true,
                                      isActive: false,
                                      refund: state.refundOrders[index],
                                    );
                                  },
                                ),
                              ),
                      ]),
                    )
                  ],
                ),
              ),
            )
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
      24.verticalSpace,
      Image.asset("assets/images/notFound.png"),
      Text(
        AppHelpers.getTranslation(TrKeys.nothingFound),
        style: Style.interSemi(size: 18.sp),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 32.w,
        ),
        child: Text(
          AppHelpers.getTranslation(TrKeys.trySearchingAgain),
          style: Style.interRegular(size: 14.sp),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
