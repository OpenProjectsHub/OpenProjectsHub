
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'floating_state.dart';

class FloatingNotifier extends StateNotifier<FloatingState> {
  FloatingNotifier() : super(const FloatingState());

  void changeScrolling(bool isScrolling){
    state = state.copyWith(isScrolling: isScrolling);
  }
}
