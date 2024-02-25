import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/di/dependency_manager.dart';

import 'orders_list_notifier.dart';
import 'orders_list_state.dart';

final ordersListProvider = StateNotifierProvider<OrdersListNotifier, OrdersListState>(
  (ref) => OrdersListNotifier(ordersRepository),
);

