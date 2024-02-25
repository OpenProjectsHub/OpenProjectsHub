import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'time_notifier.dart';
import 'time_state.dart';



final timeProvider = StateNotifierProvider<TimeNotifier, TimeState>(
  (ref) => TimeNotifier(),
);
