import 'package:shoppingapp/infrastructure/models/data/filter_model.dart';
import 'package:shoppingapp/infrastructure/models/response/new_product_pagination.dart';
import 'package:shoppingapp/infrastructure/models/response/recipes_paginate_response.dart';
import 'package:shoppingapp/infrastructure/models/response/single_recipe_response.dart';

import '../../domain/handlers/handlers.dart';
import '../../infrastructure/models/models.dart';

abstract class ProductsRepositoryFacade {
  Future<ApiResult<ProductsPaginateResponse>> searchProducts(
      {required String text, int page, int? categoryId});

  Future<ApiResult<SingleProductResponse>> getProductDetails(String uuid);

  Future<ApiResult<NewProductPagination>> getNewProductsPaginate(
      {int? shopId, required int page});

  Future<ApiResult<ProductsPaginateResponse>> getProductsPaginate(
      {int? shopId, required int page, FilterModel? filterModel});

  Future<ApiResult<ProductsPaginateResponse>> getProductsPopularPaginate({
    int? shopId,
    required int page,
  });

  Future<ApiResult<RecipesPaginateResponse>> getRecipePaginate({
    int? shopId,
    int? categoryId,
    required int page,
  });

  Future<ApiResult<ProductsPaginateResponse>> getProductsByCategoryPaginate(
      {int? shopId, required int page, required int categoryId});

  Future<ApiResult<ProductsPaginateResponse>> getMostSoldProducts({
    int? shopId,
    int? categoryId,
    int? brandId,
  });

  Future<ApiResult<ProductsPaginateResponse>> getRelatedProducts(
    int? brandId,
    int? shopId,
    int? categoryId,
  );

  Future<ApiResult<ProductCalculateResponse>> getProductCalculations(
    int stockId,
    int quantity,
  );

  Future<ApiResult<ProductCalculateResponse>> getAllCalculations(
    List<CartProductData> cartProducts,
  );

  Future<ApiResult<ProductsPaginateResponse>> getProductsByIds(
    List<int> ids,
  );

  Future<ApiResult<void>> addReview(
    String productUuid,
    String comment,
    double rating,
    String? imageUrl,
  );

  Future<ApiResult<ProductsPaginateResponse>> getNewProducts({
    int? shopId,
    int? brandId,
    int? categoryId,
    int? page,
  });

  Future<ApiResult<ProductsPaginateResponse>> getDiscountProducts({
    int? shopId,
    int? brandId,
    int? categoryId,
    int? page,
  });

  Future<ApiResult<ProductsPaginateResponse>> getProfitableProducts({
    int? brandId,
    int? categoryId,
    int? page,
  });

  Future<ApiResult<CategoriesPaginateResponse>> getRecipeCategoriesPaginate({
    int? page,
    int? shopId,
  });

  Future<ApiResult<SingleRecipeResponse>> getRecipeDetails({
    int? recipeId,
  });
}
