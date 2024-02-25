import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/domain/iterface/products.dart';
import 'package:shoppingapp/infrastructure/models/data/recipe_data.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';

import 'recipes_state.dart';

class RecipesNotifier extends StateNotifier<RecipesState> {
  final ProductsRepositoryFacade _productsRepository;

  RecipesNotifier(this._productsRepository) : super(const RecipesState());
  int recipeRefreshIndex = 1;

  Future<void> fetchRecipe(BuildContext context,int categoryId) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      recipeRefreshIndex = 1;
      state = state.copyWith(
        isLoading: true,
      );
      final response = await _productsRepository.getRecipePaginate(
        page: 1,
        categoryId: categoryId
      );
      response.when(
        success: (data) {
          state = state.copyWith(
            recipes: data.data ?? [],
            isLoading: false,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(
          context,
        );
      }
    }
  }

  Future<void> fetchRecipePage(
      BuildContext context, RefreshController productController,
      {bool isRefresh = false,required int categoryId}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (isRefresh) {
        recipeRefreshIndex = 0;
      }
      final response = await _productsRepository.getRecipePaginate(
          page: ++recipeRefreshIndex,categoryId: categoryId);
      response.when(
        success: (data) {
          if (isRefresh) {
            state = state.copyWith(
              recipes: data.data ?? [],
            );
            productController.refreshCompleted();
          } else {
            if (data.data?.isNotEmpty ?? false) {
              List<RecipeData> list = List.from(state.recipes);
              list.addAll(data.data!.toList());
              state = state.copyWith(
                recipes: list,
              );
              productController.loadComplete();
            } else {
              recipeRefreshIndex--;
              productController.loadNoData();
            }
          }
        },
        failure: (failure, status) {
          if (!isRefresh) {
            recipeRefreshIndex--;
            productController.loadFailed();
          } else {
            productController.refreshFailed();
          }
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(
          context,
        );
      }
    }
  }
}
