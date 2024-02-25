
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/infrastructure/models/data/order_active_model.dart';
import 'package:shoppingapp/infrastructure/models/data/refund_data.dart';
import '../../domain/iterface/orders.dart';
import '../../infrastructure/services/app_connectivity.dart';
import '../../infrastructure/services/app_helpers.dart';
import 'orders_list_state.dart';

class OrdersListNotifier extends StateNotifier<OrdersListState> {
  final OrdersRepositoryFacade _orderRepository;


  OrdersListNotifier(this._orderRepository,)
      : super(const OrdersListState());
  int activeOrder = 1;
  int historyOrder = 1;
  int refundOrder = 1;

  Future<void> fetchActiveOrdersPage(
      BuildContext context, RefreshController controller,
      {bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (isRefresh) {
        activeOrder = 1;
      }
      final response =
          await _orderRepository.getActiveOrders(isRefresh ? 1 : ++activeOrder);
      response.when(
        success: (data) {
          if (isRefresh) {
            state = state.copyWith(
              activeOrders: data.data ?? [],
              totalActiveCount: data.meta?.total ?? 0,
            );
            controller.refreshCompleted();
          } else {
            if (data.data?.isNotEmpty ?? false) {
              List<OrderActiveModel> list = List.from(state.activeOrders);
              list.addAll(data.data!);
              state = state.copyWith(
                activeOrders: list ,
                totalActiveCount: data.meta?.total ?? 0,
              );
              controller.loadComplete();
            } else {
              activeOrder--;
              controller.loadNoData();
            }
          }

        },
        failure: (failure, status) {
          if (!isRefresh) {
            activeOrder--;
            controller.loadFailed();
          } else {
            controller.refreshFailed();
          }
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchHistoryOrdersPage(
      BuildContext context, RefreshController controller,
      {bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (isRefresh) {
        historyOrder = 1;
      }
      final response =
      await _orderRepository.getHistoryOrders(isRefresh ? 1 : ++historyOrder);
      response.when(
        success: (data) {
          if (isRefresh) {
            state = state.copyWith(
              historyOrders: data.data ?? [],
            );
            controller.refreshCompleted();
          } else {
            if (data.data?.isNotEmpty ?? false) {
              List<OrderActiveModel> list = List.from(state.historyOrders);
              list.addAll(data.data!);
              state = state.copyWith(
                historyOrders: list,
              );
              controller.loadComplete();
            } else {
              historyOrder--;
              controller.loadNoData();
            }
          }

        },
        failure: (failure, status) {
          if (!isRefresh) {
            historyOrder--;
            controller.loadFailed();
          } else {
            controller.refreshFailed();
          }
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchRefundOrdersPage(
      BuildContext context, RefreshController controller,
      {bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (isRefresh) {
        refundOrder = 1;
      }
      final response =
      await _orderRepository.getRefundOrders(isRefresh ? 1 : ++refundOrder);
      response.when(
        success: (data) {
          if (isRefresh) {
            state = state.copyWith(
              refundOrders: data.data ?? [],
            );
            controller.refreshCompleted();
          } else {
            if (data.data?.isNotEmpty ?? false) {
              List<RefundModel> list = List.from(state.refundOrders);
              list.addAll(data.data!);
              state = state.copyWith(
                refundOrders: list,
              );
              controller.loadComplete();
            } else {
              refundOrder--;
              controller.loadNoData();
            }
          }

        },
        failure: (failure, status) {
          if (!isRefresh) {
            refundOrder--;
            controller.loadFailed();
          } else {
            controller.refreshFailed();
          }
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchActiveOrders(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isActiveLoading: true,
        activeOrders: [],
      );
      final response = await _orderRepository.getActiveOrders(1);
      response.when(
        success: (data) {
          state = state.copyWith(
            activeOrders: data.data ?? [],
            isActiveLoading: false,
            totalActiveCount: data.meta?.total ?? 0,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(
            isActiveLoading: false,
          );
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
          debugPrint('==> get active orders failure: $failure');
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchHistoryOrders(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        historyOrders: [],
        isHistoryLoading: true,
      );
      final response = await _orderRepository.getHistoryOrders(1);
      response.when(
        success: (data) {
          state = state.copyWith(
            historyOrders: data.data ?? [],
            isHistoryLoading: false,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isHistoryLoading: true);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
          debugPrint('==> get history orders failure: $failure');
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchRefundOrders(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        refundOrders: [],
        isRefundLoading: true,
      );
      final response = await _orderRepository.getRefundOrders(1);
      response.when(
        success: (data) {
          state = state.copyWith(
            refundOrders: data.data ?? [],
            isRefundLoading: false,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isRefundLoading: true);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
          debugPrint('==> get refund orders failure: $failure');
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }
}
