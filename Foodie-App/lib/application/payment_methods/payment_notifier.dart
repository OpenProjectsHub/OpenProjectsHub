import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import '../../domain/iterface/payments.dart';
import 'payment_state.dart';

class PaymentNotifier extends StateNotifier<PaymentState> {
  final PaymentsRepositoryFacade _paymentsRepository;

  PaymentNotifier(this._paymentsRepository) : super(const PaymentState());

  void change(int index) {
    state = state.copyWith(currentIndex: index);
  }

  Future<void> fetchPayments(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isPaymentsLoading: true);
      final response = await _paymentsRepository.getPayments();
      response.when(
        success: (data) {
          state = state.copyWith(
            payments: data?.data ?? [],
            isPaymentsLoading: false,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isPaymentsLoading: false);
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
}
