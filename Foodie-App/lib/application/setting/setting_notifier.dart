import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/iterface/settings.dart';
import 'package:shoppingapp/domain/iterface/user.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';

import '../../infrastructure/models/data/notification_list_data.dart';
import 'setting_state.dart';

class SettingNotifier extends StateNotifier<SettingState> {
  final SettingsRepositoryFacade _settingsRepository;
  final UserRepositoryFacade _userRepository;

  SettingNotifier(this._settingsRepository, this._userRepository)
      : super(const SettingState());

  void changeIndex(bool isChange) {
    state = state.copyWith(isLoading: isChange);
  }

  getNotificationList(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _settingsRepository.getNotificationList();

      response.when(
        success: (data) async {
          state = state.copyWith(notifications: data.data);
          final res = await _userRepository.getProfileDetails();
          res.when(
            success: (d) {
              for (int i = 0; i < data.data!.length; i++) {
                d.data?.notifications?.forEach((element) {
                  if (data.data?[i].id == element.id) {
                    updateData(context, i, element.active ?? false);
                  }
                });
              }

              state = state.copyWith(isLoading: false);
            },
            failure: (activeFailure, status) {
              state = state.copyWith(isLoading: false);
              AppHelpers.showCheckTopSnackBar(
                context,
                AppHelpers.getTranslation(activeFailure.toString()),
              );
            },
          );
        },
        failure: (activeFailure, status) {
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

  updateData(BuildContext context, int index, bool active) async {
    List<NotificationData> list = List.from(state.notifications ?? []);
    NotificationData newNotification = list[index];
    newNotification.active = active;
    list.removeAt(index);
    list.insert(index, newNotification);
    state = state.copyWith(notifications: list);
    _settingsRepository.updateNotification(state.notifications);
  }
}
