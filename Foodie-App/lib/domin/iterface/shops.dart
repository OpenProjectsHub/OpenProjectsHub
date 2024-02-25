import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppingapp/infrastructure/models/data/filter_model.dart';
import 'package:shoppingapp/infrastructure/models/response/Galleries_response.dart';
import 'package:shoppingapp/infrastructure/models/response/branches_response.dart';
import 'package:shoppingapp/infrastructure/models/response/review_count.dart';
import 'package:shoppingapp/infrastructure/models/response/review_response.dart';

import '../../domain/handlers/handlers.dart';
import '../../infrastructure/models/data/story_data.dart';
import '../../infrastructure/models/models.dart';
import '../../infrastructure/models/response/tag_response.dart';

abstract class ShopsRepositoryFacade {
  Future<ApiResult<ShopsPaginateResponse>> getShopFilter(
      {int? categoryId, required int page, required String type});

  Future<ApiResult<ShopsPaginateResponse>> getPickupShops();

  Future<ApiResult<ShopsPaginateResponse>> searchShops(
      {required String text, int? categoryId});

  Future<ApiResult<SingleShopResponse>> getNearbyShop();

  Future<ApiResult<ShopsPaginateResponse>> getNearbyShops();

  Future<ApiResult<ShopsPaginateResponse>> getAllShops(int page,
      {String? type,
      FilterModel? filterModel,
      required bool isOpen,
        LatLng? latLng,
        bool? work24,bool? newShop});

  Future<ApiResult<TagResponse>> getTags();

  Future<ApiResult<bool>> checkDriverZone(LatLng location, {int? shopId});

  Future<ApiResult<PriceModel>> getSuggestPrice();

  Future<ApiResult<ShopsPaginateResponse>> getShopsRecommend(int page);

  Future<ApiResult<List<List<StoryModel?>?>?>> getStory(int page);

  Future<ApiResult<SingleShopResponse>> getSingleShop({required int uuid});

  Future<ApiResult<SingleShopResponse>> getSingleShopMain();

  Future<ApiResult<GalleriesResponse>> getGalleries(int shopId);

  Future<ApiResult<ReviewResponseModel>> getReview(int shopId, int page);

  Future<ApiResult<ReviewCountModel>> getReviewCount(int shopId);

  Future<ApiResult<BranchResponse>> getShopBranch({required int uuid});

  Future<ApiResult<ShopsPaginateResponse>> getShopsByIds(
    List<int> shopIds,
  );

  Future<ApiResult<void>> createShop({
    required double tax,
    required double deliveryTo,
    required double deliveryFrom,
    required String deliveryType,
    required String phone,
    required String name,
    required String type,
    required num category,
    required String description,
    required double startPrice,
    required double perKm,
    required AddressData address,
    String? logoImage,
    String? backgroundImage,
  });
}
