import 'package:shoppingapp/infrastructure/models/models.dart';
import '../../domain/handlers/handlers.dart';

abstract class BrandsRepositoryFacade {
  Future<ApiResult<BrandsPaginateResponse>> getBrandsPaginate(int page);

  Future<ApiResult<BrandsPaginateResponse>> searchBrands(String query);

  Future<ApiResult<SingleBrandResponse>> getSingleBrand(int id);

  Future<ApiResult<BrandsPaginateResponse>> getAllBrands();
}
