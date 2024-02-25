import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoppingapp/infrastructure/models/data/recipe_data.dart';



part 'recipe_details_state.freezed.dart';

@freezed
class RecipeDetailsState with _$RecipeDetailsState {
  const factory RecipeDetailsState({
    @Default(false) bool isLoading,
    RecipeData? recipeData,
  }) = _RecipeDetailsState;

  const RecipeDetailsState._();
}
