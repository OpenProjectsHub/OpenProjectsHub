import 'package:dio/dio.dart';
import 'package:shoppingapp/infrastructure/services/app_constants.dart';

import 'token_interceptor.dart';

class HttpService {

  Dio client({bool requireAuth = false,bool routing = false}) => Dio(
    BaseOptions(
      baseUrl: routing ? AppConstants.drawingBaseUrl : AppConstants.baseUrl,
      connectTimeout: const Duration(minutes: 10),
      receiveTimeout: const Duration(minutes: 10),
      sendTimeout: const Duration(minutes: 10),
      headers: {
        'Accept':
        'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
        'Content-type': 'application/json'
      },
    ),
  )
    ..interceptors.add(TokenInterceptor(requireAuth: requireAuth))
    ..interceptors.add(LogInterceptor(
      responseHeader: false,
      requestHeader: true,
      responseBody: true,
      requestBody: true
    ));
}
