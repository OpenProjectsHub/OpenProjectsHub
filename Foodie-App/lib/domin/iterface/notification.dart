
import 'package:shoppingapp/domain/handlers/api_result.dart';
import 'package:shoppingapp/infrastructure/models/response/count_of_notifications_data.dart';
import 'package:shoppingapp/infrastructure/models/response/notification_response.dart';

abstract class NotificationRepositoryFacade {

  Future<ApiResult<NotificationResponse>> getNotifications({
    int? page,
    required String type,
  });

  Future<ApiResult<NotificationResponse>> getAllNotifications();

  Future<ApiResult<dynamic>> readOne({
    int? id,
  });

  Future<ApiResult<NotificationResponse>> readAll();


  Future<ApiResult<CountNotificationModel>> getCount();
}
