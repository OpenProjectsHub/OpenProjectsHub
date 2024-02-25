
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoppingapp/infrastructure/models/data/order_active_model.dart';
import 'package:shoppingapp/infrastructure/models/data/refund_data.dart';


part 'orders_list_state.freezed.dart';

@freezed
class OrdersListState with _$OrdersListState {

  const factory OrdersListState({

    @Default(false) bool isActiveLoading,
    @Default(false) bool isHistoryLoading,
    @Default(false) bool isRefundLoading,
    @Default(0) int totalActiveCount,
    @Default([]) List<OrderActiveModel> activeOrders,
    @Default([]) List<OrderActiveModel> historyOrders,
    @Default([]) List<RefundModel> refundOrders,
  }) = _OrdersListState;

  const OrdersListState._();
}