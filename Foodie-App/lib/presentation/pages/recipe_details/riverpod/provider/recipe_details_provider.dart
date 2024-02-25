import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/di/dependency_manager.dart';

import '../notifier/recipe_details_notifier.dart';
import '../state/recipe_details_state.dart';

final recipeDetailsProvider = StateNotifierProvider.autoDispose<
    RecipeDetailsNotifier, RecipeDetailsState>(
  (ref) => RecipeDetailsNotifier(productsRepository),
);
