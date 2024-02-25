import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/domain/iterface/notification.dart';
import 'package:shoppingapp/infrastructure/models/response/notification_response.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';

import 'notification_state.dart';

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRepositoryFacade _notificationRepository;

  int _news = 0;
  int _orders = 0;
  int _reservations = 0;

  NotificationNotifier(this._notificationRepository)
      : super(const NotificationState());

  Future<void> fetchNews(BuildContext context) async {
    state = state.copyWith(isAllNotificationsLoading: true);

    final response =
        await _notificationRepository.getNotifications(type: "news_publish");
    response.when(
      success: (data) {
        state = state.copyWith(
            isAllNotificationsLoading: false, news: data.data ?? []);
      },
      failure: (failure, s) {
        AppHelpers.showCheckTopSnackBar(context, failure.toString());
      },
    );
  }

  Future<void> fetchNewsPaginate(
      {VoidCallback? checkYourNetwork,
      RefreshController? refreshController,
      bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (isRefresh) {
      _news = 0;
    }
    if (connected) {
      final response = await _notificationRepository.getNotifications(
        type: "news_publish",
        page: ++_news,
      );
      response.when(
        success: (data) async {
          final List<NotificationModel> newList = List.from(state.news);
          newList.addAll(data.data ?? []);
          state = state.copyWith(
            news: isRefresh ? (data.data ?? []) : newList,
          );
          if (data.data?.isEmpty ?? true) {
            refreshController?.loadNoData();
          }
          if (isRefresh) {
            refreshController?.refreshCompleted();
          } else {
            refreshController?.loadComplete();
          }
        },
        failure: (failure, s) {
          debugPrint('==> get notifications more failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> fetchOrders(BuildContext context) async {
    state = state.copyWith(isAllNotificationsLoading: true);

    final response =
        await _notificationRepository.getNotifications(type: "status_changed");
    response.when(
      success: (data) {
        state = state.copyWith(
            isAllNotificationsLoading: false, orders: data.data ?? []);
      },
      failure: (failure, s) {
        AppHelpers.showCheckTopSnackBar(context, failure.toString());
      },
    );
  }

  Future<void> fetchOrdersPaginate(
      {VoidCallback? checkYourNetwork,
      RefreshController? refreshController,
      bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (isRefresh) {
      _orders = 0;
    }
    if (connected) {
      final response = await _notificationRepository.getNotifications(
          page: ++_orders, type: "status_changed");
      response.when(
        success: (data) async {
          final List<NotificationModel> newList = List.from(state.orders);
          newList.addAll(data.data ?? []);
          state = state.copyWith(
            orders: isRefresh ? (data.data ?? []) : newList,
          );
          if (data.data?.isEmpty ?? true) {
            refreshController?.loadNoData();
          }
          if (isRefresh) {
            refreshController?.refreshCompleted();
          } else {
            refreshController?.loadComplete();
          }
        },
        failure: (failure, s) {
          debugPrint('==> get notifications more failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> fetchReservation(BuildContext context) async {
    state = state.copyWith(isAllNotificationsLoading: true);

    final response =
        await _notificationRepository.getNotifications(type: "booking_status");
    response.when(
      success: (data) {
        state = state.copyWith(
            isAllNotificationsLoading: false, reservations: data.data ?? []);
      },
      failure: (failure, s) {
        AppHelpers.showCheckTopSnackBar(context, failure.toString());
      },
    );
  }

  Future<void> fetchReservationsPaginate(
      {VoidCallback? checkYourNetwork,
      RefreshController? refreshController,
      bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (isRefresh) {
      _reservations = 0;
    }
    if (connected) {
      final response = await _notificationRepository.getNotifications(
          page: ++_reservations, type: "booking_status");
      response.when(
        success: (data) async {
          final List<NotificationModel> newList = List.from(state.reservations);
          newList.addAll(data.data ?? []);
          state = state.copyWith(
            reservations: isRefresh ? (data.data ?? []) : newList,
          );
          if (data.data?.isEmpty ?? true) {
            refreshController?.loadNoData();
          }
          if (isRefresh) {
            refreshController?.refreshCompleted();
          } else {
            refreshController?.loadComplete();
          }
        },
        failure: (failure, s) {
          debugPrint('==> get notifications more failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> readAll(BuildContext context) async {
    List<NotificationModel> notif = List.from(state.news);
    List<NotificationModel> notifOrders = List.from(state.orders);
    List<NotificationModel> notifReservation = List.from(state.reservations);
    for (var i = 0; i < notif.length; i++) {
      if (notif[i].readAt == null) {
        notif[i] = notif[i].copyWith(readAt: DateTime.now());
      }
    }

    for (var i = 0; i < notifOrders.length; i++) {
      if (notifOrders[i].readAt == null) {
        notifOrders[i] = notifOrders[i].copyWith(readAt: DateTime.now());
      }
    }
    for (var i = 0; i < notifReservation.length; i++) {
      if (notifReservation[i].readAt == null) {
        notifReservation[i] =
            notifReservation[i].copyWith(readAt: DateTime.now());
      }
    }
    state = state.copyWith(
      news: notif,
      orders: notifOrders,
      reservations: notifReservation,
      countOfNotifications:
          state.countOfNotifications?.copyWith(notification: 0),
    );

    final response = await _notificationRepository.readAll();
    response.when(
      success: (data) {},
      failure: (failure, s) {
        AppHelpers.showCheckTopSnackBar(context, failure.toString());
      },
    );
  }

  Future<void> readOne(BuildContext context,
      {int? id, required int index, required int typeIndex}) async {
    List<NotificationModel> notif = List.from(typeIndex == 0
        ? state.news
        : typeIndex == 1
            ? state.orders
            : state.reservations);
    notif[index] = notif[index].copyWith(
      readAt: DateTime.now(),
    );
    final notification = state.countOfNotifications?.copyWith(
        notification: (state.countOfNotifications?.notification ?? 0) - 1);
    if (typeIndex == 0) {
      state = state.copyWith(news: notif, countOfNotifications: notification);
    } else if (typeIndex == 1) {
      state = state.copyWith(orders: notif, countOfNotifications: notification);
    } else if (typeIndex == 2) {
      state = state.copyWith(
          reservations: notif, countOfNotifications: notification);
    }

    final response = await _notificationRepository.readOne(id: id);
    response.when(
      success: (data) {},
      failure: (failure, s) {
        AppHelpers.showCheckTopSnackBar(context, failure.toString());
      },
    );
  }

  Future<void> fetchCount(BuildContext context) async {
    final response = await _notificationRepository.getCount();
    response.when(
      success: (data) {
        state = state.copyWith(countOfNotifications: data);
      },
      failure: (failure, s) {
        AppHelpers.showCheckTopSnackBar(context, failure.toString());
      },
    );
  }
}
