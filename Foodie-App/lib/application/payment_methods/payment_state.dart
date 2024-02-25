
import 'package:freezed_annotation/freezed_annotation.dart';



part 'payment_state.freezed.dart';

@freezed
class PaymentState with _$PaymentState {

  const factory PaymentState({
    @Default(0) int currentIndex,
    @Default(false) bool isPaymentsLoading,
    @Default([]) List payments,
  }) = _PaymentState;

  const PaymentState._();
}