import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'floating_notifier.dart';
import 'floating_state.dart';

final floatingProvider = StateNotifierProvider<FloatingNotifier, FloatingState>(
  (ref) => FloatingNotifier(),
);
