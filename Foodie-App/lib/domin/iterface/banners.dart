
import 'package:shoppingapp/infrastructure/models/models.dart';
import '../../domain/handlers/handlers.dart';

abstract class BannersRepositoryFacade {
  Future<ApiResult<BannersPaginateResponse>> getBannersPaginate({
   required int page,
  });

  Future<ApiResult<BannerData>> getBannerById(int? bannerId);

  Future<ApiResult<void>> likeBanner(int? bannerId);
}
