import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_notifier.dart';
import 'app_state.dart';

final appProvider = StateNotifierProvider<AppNotifier, AppState>(
  (ref) => AppNotifier(),
);
