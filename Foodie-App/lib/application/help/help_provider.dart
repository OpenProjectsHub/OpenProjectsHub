import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/di/dependency_manager.dart';
import 'help_notifier.dart';
import 'help_state.dart';

final helpProvider = StateNotifierProvider<HelpNotifier, HelpState>(
  (ref) => HelpNotifier(settingsRepository),
);
