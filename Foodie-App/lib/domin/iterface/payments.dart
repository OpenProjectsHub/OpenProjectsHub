import 'package:shoppingapp/infrastructure/models/models.dart';
import '../../domain/handlers/handlers.dart';

abstract class PaymentsRepositoryFacade {
  Future<ApiResult<PaymentsResponse?>> getPayments();

  Future<ApiResult<TransactionsResponse>> createTransaction({
    required int orderId,
    required int paymentId,
  });
}
