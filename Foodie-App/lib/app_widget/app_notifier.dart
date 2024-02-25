import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import '../../infrastructure/services/local_storage.dart';
import 'app_state.dart';

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier() : super(const AppState()) {
    fetchThemeAndLocale();
  }

  Future<void> fetchThemeAndLocale() async {
    final isDarkMode = LocalStorage.instance.getAppThemeMode();
    final lang = LocalStorage.instance.getLanguage();
    final ltr = LocalStorage.instance.getLangLtr();
    state = state.copyWith(
      isDarkMode: isDarkMode,
      activeLanguage: lang,
      isLtr: ltr,
    );
  }

  Future<void> changeTheme(bool? isDarkMode) async {
    await LocalStorage.instance.setAppThemeMode(isDarkMode ?? false);
    state = state.copyWith(isDarkMode: isDarkMode ?? false);
  }

  Future<void> changeLocale(LanguageData? language) async {
    await LocalStorage.instance.setLanguageData(language);
    await LocalStorage.instance.setLangLtr(language?.backward);
    state = state.copyWith(
      activeLanguage: language,
      isLtr: language?.backward == 0,
    );
  }
}
