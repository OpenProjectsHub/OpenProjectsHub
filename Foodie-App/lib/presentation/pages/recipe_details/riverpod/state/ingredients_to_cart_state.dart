import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredients_to_cart_state.freezed.dart';

@freezed
class IngredientsToCartState with _$IngredientsToCartState {
  const factory IngredientsToCartState({
    @Default(false) bool isLoading,
    @Default(false) bool added,
  }) = _IngredientsToCartState;

  const IngredientsToCartState._();
}
