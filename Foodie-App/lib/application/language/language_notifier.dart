import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/iterface/settings.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';


import 'language_state.dart';


class LanguageNotifier extends StateNotifier<LanguageState> {
  final SettingsRepositoryFacade _settingsRepository;

  LanguageNotifier(this._settingsRepository) : super(const LanguageState());

  void change(int index) {
    state = state.copyWith(index: index);
    LocalStorage.instance.setLanguageData(state.list[index]);
  }


  Future<void> getLanguages(BuildContext context) async {
    final connect = await AppConnectivity.connectivity();
    if (connect) {
      state = state.copyWith(isLoading: true, isSuccess: false);
      final response = await _settingsRepository.getLanguages();
      response.when(
        success: (data) {
          final List<LanguageData> languages = data.data ?? [];
          final lang = LocalStorage.instance.getLanguage();

          for (int i = 0; i < languages.length; i++) {
            if (languages[i].id == lang?.id) {
              state = state.copyWith(
                isLoading: false,
                list: data.data ?? [],
                index: i,
              );
              return;
            }
          }
          LocalStorage.instance.setLanguageData(data.data?.firstWhere((element) => element.isDefault == 1));
          state = state.copyWith(
            isLoading: false,
            list: data.data ?? [],
            index: 0,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (!mounted) return;
      AppHelpers.showNoConnectionSnackBar(context);
    }
  }


  Future<void> makeSelectedLang(BuildContext context) async {
    final storage = LocalStorage.instance;
    storage.setLanguageSelected(true);
    storage.setLanguageData(state.list[state.index]);
    storage.setLangLtr(state.list[state.index].backward);
    await getTranslations(context);
  }


  Future<void> getTranslations(BuildContext context) async {
    final connect = await AppConnectivity.connectivity();
    if (connect) {
      state = state.copyWith(isLoading: true, isSuccess: false);
      final response = await _settingsRepository.getMobileTranslations();
      response.when(
        success: (data) {
          LocalStorage.instance.setTranslations(data.data);
          state = state.copyWith(isLoading: false, isSuccess: true);
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (!mounted) return;
      context.replaceRoute(const NoConnectionRoute());
    }
  }
}
