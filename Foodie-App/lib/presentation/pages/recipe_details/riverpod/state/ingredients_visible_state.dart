import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredients_visible_state.freezed.dart';

@freezed
class IngredientsVisibleState with _$IngredientsVisibleState {
  const factory IngredientsVisibleState({
    @Default(false) bool isVisible,
  }) = _IngredientsVisibleState;

  const IngredientsVisibleState._();
}
