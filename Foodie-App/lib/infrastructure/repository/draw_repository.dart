import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppingapp/domain/di/injection.dart';
import 'package:shoppingapp/domain/handlers/http_service.dart';
import 'package:shoppingapp/domain/handlers/network_exceptions.dart';
import 'package:shoppingapp/domain/iterface/draw.dart';
import 'package:shoppingapp/infrastructure/models/response/draw_routing_response.dart';
import 'package:shoppingapp/infrastructure/services/app_constants.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';

import '../../domain/handlers/api_result.dart';

class DrawRepository implements DrawRepositoryFacade {
  @override
  Future<ApiResult<DrawRouting>> getRouting({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      final client =
      inject<HttpService>().client(requireAuth: false, routing: true);
      final response = await client.get(
        '/v2/directions/driving-car?api_key=${AppConstants.routingKey}&start=${start.longitude},${start.latitude}&end=${end.longitude},${end.latitude}',
      );
      return ApiResult.success(
        data: DrawRouting.fromJson(response.data),
      );
    } catch (e) {
      return ApiResult.failure(error: AppHelpers.errorHandler(e),statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}