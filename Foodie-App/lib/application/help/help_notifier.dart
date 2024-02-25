
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';

import '../../domain/iterface/settings.dart';
import '../../infrastructure/services/app_connectivity.dart';
import 'help_state.dart';



class HelpNotifier extends StateNotifier<HelpState> {
  final SettingsRepositoryFacade _settingsRepository;
  HelpNotifier(this._settingsRepository) : super(const HelpState());

  Future<void> fetchHelp(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _settingsRepository.getFaq();
      response.when(
        success: (data) async {
          state = state.copyWith(
            isLoading: false,
            data: data,
          );
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

}
