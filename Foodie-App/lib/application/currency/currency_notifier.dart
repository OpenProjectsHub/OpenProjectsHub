import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/iterface/currencies.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';

import 'currency_state.dart';

class CurrencyNotifier extends StateNotifier<CurrencyState> {
  final CurrenciesRepositoryFacade _currenciesRepository;

  CurrencyNotifier(this._currenciesRepository) : super(const CurrencyState());

  Future<void> fetchCurrency(BuildContext context) async {

      final connected = await AppConnectivity.connectivity();
      if (connected) {
        state = state.copyWith(isLoading: true);
        final response = await _currenciesRepository.getCurrencies();
        response.when(
          success: (data) async {
            CurrencyData currencyData =
                LocalStorage.instance.getSelectedCurrency();

            for (int i = 0; i < data.data!.length; i++) {
              if (data.data![i].id == currencyData.id) {
                state = state.copyWith(index: i);
                LocalStorage.instance.setSelectedCurrency(data.data![i]);
                break;
              }else{
                LocalStorage.instance.setSelectedCurrency(data.data![0]);
              }
            }

            state = state.copyWith(isLoading: false, list: data.data ?? []);
          },
          failure: (activeFailure,status) {
            state = state.copyWith(isLoading: false);
            AppHelpers.showCheckTopSnackBar(
              context,
              AppHelpers.getTranslation(activeFailure.toString()),
            );
          },
        );
      } else {
        if (mounted) {
          AppHelpers.showNoConnectionSnackBar(context);
        }
      }

  }

  void change(int index) {
    LocalStorage.instance.setSelectedCurrency(state.list[index]);
    state = state.copyWith(index: index);
  }
}
