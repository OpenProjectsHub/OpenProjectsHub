import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/di/dependency_manager.dart';


import '../notifier/ingredients_to_cart_notifier.dart';
import '../state/ingredients_to_cart_state.dart';

final ingredientsToCartProvider =
    StateNotifierProvider<IngredientsToCartNotifier, IngredientsToCartState>(
  (ref) => IngredientsToCartNotifier(cartRepository),
);
