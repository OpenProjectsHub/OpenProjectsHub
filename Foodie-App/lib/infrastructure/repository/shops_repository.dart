import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppingapp/domain/di/injection.dart';
import 'package:shoppingapp/domain/handlers/http_service.dart';
import 'package:shoppingapp/domain/iterface/shops.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import 'package:shoppingapp/infrastructure/models/request/only_shop.dart';
import 'package:shoppingapp/infrastructure/models/request/search_shop.dart';
import 'package:shoppingapp/infrastructure/models/request/shop_request.dart';
import 'package:shoppingapp/infrastructure/models/response/Galleries_response.dart';
import 'package:shoppingapp/infrastructure/models/response/branches_response.dart';
import 'package:shoppingapp/infrastructure/models/response/review_count.dart';
import 'package:shoppingapp/infrastructure/models/response/review_response.dart';
import 'package:shoppingapp/infrastructure/services/app_constants.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import '../../../domain/handlers/handlers.dart';
import '../models/data/filter_model.dart';
import '../models/data/story_data.dart';
import '../models/request/story_request.dart';
import '../models/response/tag_response.dart';

class ShopsRepository implements ShopsRepositoryFacade {
  @override
  Future<ApiResult<ShopsPaginateResponse>> searchShops(
      {required String text, int? categoryId}) async {
    final data = SearchShopModel(text: text, categoryId: categoryId);
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops/search',
        queryParameters: data.toJson(),
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search shops failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ShopsPaginateResponse>> getNearbyShops() async {
    final data = {
      'lang': LocalStorage.instance.getLanguage()?.locale ?? "en",
      "address": {
        "latitude":
            LocalStorage.instance.getAddressSelected()?.location?.latitude ??
                AppConstants.demoLatitude,
        "longitude":
            LocalStorage.instance.getAddressSelected()?.location?.longitude ??
                AppConstants.demoLongitude
      }
    };
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops/nearby',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get nearby shops failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleShopResponse>> getNearbyShop() async {
    final data = {
      'lang': LocalStorage.instance.getLanguage()?.locale ?? "en",
      "address": {
        "latitude":
            LocalStorage.instance.getAddressSelected()?.location?.latitude ??
                AppConstants.demoLatitude,
        "longitude":
            LocalStorage.instance.getAddressSelected()?.location?.longitude ??
                AppConstants.demoLongitude
      }
    };
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/branch/check-smallest',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SingleShopResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get nearby shops failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ShopsPaginateResponse>> getAllShops(int page,
      {String? type,
      FilterModel? filterModel,
      required bool isOpen,
      LatLng? latLng,
      bool? work24,
      bool? newShop}) async {
    final data = ShopRequest(
        page: page,
        type: type,
        price: filterModel?.price,
        rating: filterModel?.rating,
        freeDelivery: filterModel?.isFreeDelivery,
        orderBy: filterModel?.sort,
        onlyOpen: isOpen,
        latLon: latLng,
        work_24_7: work24,
        deals: filterModel?.isDeal,
        take: filterModel?.offer);
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops/paginate',
        queryParameters: data.toJson(),
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get all shops failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<BranchResponse>> getShopBranch({required int uuid}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/branches?lang=en&shop_id=$uuid&page=1&perPage=100',
      );
      return ApiResult.success(
        data: BranchResponse.fromJson(response.data),
      );
    } catch (e) {
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleShopResponse>> getSingleShop(
      {required int uuid}) async {
    final data = OnlyShopRequest();
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get('/api/v1/rest/shops/$uuid',
          queryParameters: data.toJson());
      return ApiResult.success(
        data: SingleShopResponse.fromJson(response.data),
      );
    } catch (e) {
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ShopsPaginateResponse>> getShopFilter(
      {int? categoryId, required int page, required String type}) async {
    final data = {
      "type": type,
      'category_id': categoryId,
      'perPage': 5,
      "open": 1,
      "page": page,
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get work filter shops failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ShopsPaginateResponse>> getPickupShops() async {
    final data = {
      'delivery': 'pickup',
      'perPage': 100,
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get pickup shops failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ShopsPaginateResponse>> getShopsByIds(
    List<int> shopIds,
  ) async {
    final data = <String, dynamic>{
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    for (int i = 0; i < shopIds.length; i++) {
      data['shops[$i]'] = shopIds[i];
    }
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get shops by ids failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
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
  }) async {
    final data = {
      "price_per_km": perKm,
      'tax': tax,
      'type': type,
      'categories[0]': category,
      'delivery_time_type': deliveryType,
      'location': address.location?.toJson(),
      'phone': phone,
      'delivery_time_from': deliveryFrom,
      'delivery_time_to': deliveryTo,
      'title': {LocalStorage.instance.getLanguage()?.locale ?? "": name},
      'description': {
        LocalStorage.instance.getLanguage()?.locale ?? "": description
      },
      'price': startPrice,
      'address': {
        LocalStorage.instance.getLanguage()?.locale ?? "":
            "${address.title}, ${address.address}"
      },
      if (logoImage != null) 'images[0]': logoImage,
      if (backgroundImage != null) "images[1]": backgroundImage,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/user/shops',
        queryParameters: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> create shop failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ShopsPaginateResponse>> getShopsRecommend(int page) async {
    final data = ShopRequest(page: page, type: "restaurant", onlyOpen: true);
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops/recommended',
        queryParameters: data.toJson(),
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get all shops recommend failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<List<List<StoryModel?>?>?>> getStory(int page) async {
    final data = StoryRequest(page: page);
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/stories/paginate',
        queryParameters: data.toJson(),
      );
      return ApiResult.success(
        data: storyModelFromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get all story failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<TagResponse>> getTags() async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops-takes',
      );
      return ApiResult.success(
        data: TagResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get all take failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<bool>> checkDriverZone(LatLng location,
      {int? shopId}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final data = <String, dynamic>{
        'address[latitude]': location.latitude,
        'address[longitude]': location.longitude,
      };
      dynamic response;
      if (shopId == null) {
        response = await client.get(
            '/api/v1/rest/shop//delivery-zone/check/distance',
            queryParameters: data);
      } else {
        response = await client.get(
            '/api/v1/rest/shop/$shopId/delivery-zone/check/distance',
            queryParameters: data);
      }

      return ApiResult.success(
        data: response.data["status"],
      );
    } catch (e) {
      debugPrint('==> get delivery zone failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<PriceModel>> getSuggestPrice() async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final data = {
        if (LocalStorage.instance.getSelectedCurrency().id != null)
        "currency_id": LocalStorage.instance.getSelectedCurrency().id
      };
      final response = await client.get('/api/v1/rest/products-avg-prices',
          queryParameters: data);
      return ApiResult.success(
        data: PriceModel.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get all price failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SingleShopResponse>> getSingleShopMain() async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get('/api/v1/rest/main-shop');
      return ApiResult.success(
        data: SingleShopResponse.fromJson(response.data),
      );
    } catch (e) {
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<GalleriesResponse>> getGalleries(int shopId) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get('/api/v1/rest/shops/$shopId/galleries');
      return ApiResult.success(
        data: GalleriesResponse.fromJson(response.data),
      );
    } catch (e) {
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ReviewResponseModel>> getReview(int shopId, int page) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get('/api/v1/rest/shops/$shopId/reviews',
          queryParameters: {"page": page, "perPage": 10});
      return ApiResult.success(
        data: ReviewResponseModel.fromJson(response.data),
      );
    } catch (e) {
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ReviewCountModel>> getReviewCount(int shopId) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response =
          await client.get('/api/v1/rest/shops/$shopId/reviews-group-rating');
      return ApiResult.success(
        data: ReviewCountModel.fromJson(response.data),
      );
    } catch (e) {
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}
