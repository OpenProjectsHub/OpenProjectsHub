import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoppingapp/infrastructure/models/data/recipe_data.dart';


part 'recipes_state.freezed.dart';

@freezed
class RecipesState with _$RecipesState {
  const factory RecipesState({
    @Default(false) bool isLoading,
    @Default([]) List<RecipeData> recipes,
  }) = _RecipesState;

  const RecipesState._();
}
