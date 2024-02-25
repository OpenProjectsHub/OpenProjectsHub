import 'package:flutter/material.dart';
import 'package:shoppingapp/domain/di/injection.dart';
import 'package:shoppingapp/domain/handlers/api_result.dart';
import 'package:shoppingapp/domain/handlers/http_service.dart';
import 'package:shoppingapp/domain/handlers/network_exceptions.dart';
import 'package:shoppingapp/domain/iterface/notification.dart';
import 'package:shoppingapp/infrastructure/models/response/count_of_notifications_data.dart';
import 'package:shoppingapp/infrastructure/models/response/notification_response.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';

class NotificationRepositoryImpl extends NotificationRepositoryFacade {
  @override
  Future<ApiResult<NotificationResponse>> getNotifications({
    int? page,
    required String type,
  }) async {
    final data = {
      if (page != null) 'page': page,
      'column': 'created_at',
      'sort': 'desc',
      'perPage': 7,
      'type': type,
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/notifications',
        queryParameters: data,
      );
      return ApiResult.success(
        data: NotificationResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get notification failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<NotificationResponse>> readAll() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/notifications/read-all',
      );
      return ApiResult.success(
        data: NotificationResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get notification failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> readOne({int? id}) async {
    final data = {
      if (id != null) '$id': id,
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/notifications/$id/read-at',
        queryParameters: data,
      );
      return const ApiResult.success(
        data: true,
      );
    } catch (e) {
      debugPrint('==> get notification failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }


  @override
  Future<ApiResult<NotificationResponse>> getAllNotifications() async {
    final data = {
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/notifications',
        queryParameters: data,
      );
      return ApiResult.success(
        data: NotificationResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get notification failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<CountNotificationModel>> getCount() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/user/profile/notifications-statistic',
      );
      return ApiResult.success(
        data: CountNotificationModel.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get notification failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}
