import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/ingredients_visible_state.dart';

class IngredientsVisibleNotifier
    extends StateNotifier<IngredientsVisibleState> {
  IngredientsVisibleNotifier() : super(const IngredientsVisibleState());

  void toggleVisibility({bool? value}) {
    state = state.copyWith(isVisible: value ?? !state.isVisible);
  }
}
