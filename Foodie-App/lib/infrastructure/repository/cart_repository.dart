import 'package:flutter/material.dart';
import 'package:shoppingapp/domain/handlers/api_result.dart';
import 'package:shoppingapp/domain/iterface/cart.dart';
import 'package:shoppingapp/infrastructure/models/data/cart_data.dart';
import 'package:shoppingapp/infrastructure/models/request/cart_request.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';

import '../../domain/di/injection.dart';
import '../../domain/handlers/http_service.dart';
import '../../domain/handlers/network_exceptions.dart';
import '../services/local_storage.dart';

class CartRepository implements CartRepositoryFacade {
  @override
  Future<ApiResult<CartModel>> createCart({required CartRequest cart}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/user/cart/open',
        data: cart.toJson(),
      );
      return ApiResult.success(
        data: CartModel.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get open createAndCart failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<CartModel>> insertCart({required CartRequest cart}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/user/cart/insert-product',
        data: cart.toJsonInsert(),
      );
      return ApiResult.success(
        data: CartModel.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get insert failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<CartModel>> createAndCart(
      {required CartRequest cart}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      debugPrint('==> get open Add Cart failure: ${cart.toJson()}');
      final response = await client.post(
        '/api/v1/dashboard/user/cart',
        data: cart.toJson(),
      );
      return ApiResult.success(
        data: CartModel.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get open Add Cart failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<CartModel>> getCart() async {
    final data = {
      if (LocalStorage.instance.getSelectedCurrency().id != null)
      'currency_id': LocalStorage.instance.getSelectedCurrency().id,
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/user/cart',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CartModel.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get open getCart failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<CartModel>> deleteCart({required int cartId}) async {
    final data = {
      'ids[0]': cartId,
    };

    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/user/cart/delete',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CartModel(),
      );
    } catch (e) {
      debugPrint('==> get open deleteCart failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> deleteUser(
      {required int cartId, required String userId}) async {
    final data = {'cart_id': cartId, "ids[0]": userId};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/user/cart/member/delete',
        queryParameters: data,
      );
      return const ApiResult.success(
        data: null,
      );
    } catch (e) {
      debugPrint('==> get open deleteCart failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> startGroupOrder({required int cartId}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/user/cart/set-group/$cartId',
      );
      return const ApiResult.success(
        data: null,
      );
    } catch (e) {
      debugPrint('==> get open deleteCart failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<CartModel>> removeProductCart(
      {required int cartDetailId,List<int>? listOfId}) async {
    final data = {
      for (int i = 0; i < (listOfId?.length ?? 0); i++)
        'ids[${i + 1}]': listOfId?[i],
      'ids[0]': cartDetailId,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/user/cart/product/delete',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CartModel(),
      );
    } catch (e) {
      debugPrint('==> get open removeProductCart failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}
