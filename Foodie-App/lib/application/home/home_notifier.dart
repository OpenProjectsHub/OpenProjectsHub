import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/application/shop_order/shop_order_provider.dart';
import 'package:shoppingapp/domain/handlers/api_result.dart';
import 'package:shoppingapp/domain/iterface/banners.dart';
import 'package:shoppingapp/domain/iterface/categories.dart';
import 'package:shoppingapp/domain/iterface/products.dart';
import 'package:shoppingapp/domain/iterface/shops.dart';
import 'package:shoppingapp/infrastructure/models/data/story_data.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import 'package:shoppingapp/infrastructure/models/response/new_product_pagination.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/app_constants.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/marker_image_cropper.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';

import 'home_state.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final CategoriesRepositoryFacade _categoriesRepository;
  final ShopsRepositoryFacade _shopsRepository;
  final BannersRepositoryFacade _bannersRepository;
  final ProductsRepositoryFacade _productsRepository;

  HomeNotifier(this._categoriesRepository, this._bannersRepository,
      this._shopsRepository, this._productsRepository)
      : super(
          const HomeState(),
        );
  int page = 1;
  int categoryIndex = 1;
  int storyIndex = 1;
  int bannerIndex = 1;
  int productRefreshIndex = 1;
  int marketRefreshIndex = 1;
  int productPopularRefreshIndex = 1;
  int recipeCategoryRefreshIndex = 1;

  void setAddress([AddressData? data]) async {
    AddressData? addressData = LocalStorage.instance.getAddressSelected();
    state = state.copyWith(addressData: data ?? addressData);
  }

  void checkBranch(BuildContext context) async {
    final res = await _shopsRepository.getNearbyShop();
    res.when(success: (shop) async {
      if (LocalStorage.instance.getShopId() != shop.data?.id) {
        AppHelpers.showAlertDialog(
            context: context,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.doYouChangeBranch),
                  style: Style.interNormal(),
                  textAlign: TextAlign.center,
                ),
                16.verticalSpace,
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                            background: Style.transparent,
                            borderColor: Style.black,
                            title: AppHelpers.getTranslation(TrKeys.cancel),
                            onPressed: () {
                              Navigator.pop(context);
                            })),
                    16.horizontalSpace,
                    Expanded(
                        child: CustomButton(
                            title: AppHelpers.getTranslation(TrKeys.apply),
                            onPressed: () {
                              LocalStorage.instance.setShopId(shop.data?.id);
                              state = state.copyWith(
                                  selectBranchId: shop.data?.id ?? 0);
                              fetchProducts(context);
                              Navigator.pop(context);
                            })),
                  ],
                )
              ],
            ));
      }
      state = state.copyWith(
        selectBranchId: shop.data?.id ?? 0,
      );
    }, failure: (failure, status) {
      state = state.copyWith(isProductLoading: false);
    });
  }

  void setSelectCategory(int index, BuildContext context) {
    if (state.selectIndexCategory == index) {
      state =
          state.copyWith(selectIndexCategory: -1, isSelectCategoryLoading: 0);
    } else {
      state = state.copyWith(
        selectIndexCategory: index,
      );
      fetchFilterProducts(context);
    }
  }

  setInitBranchId() {
    state = state.copyWith(changeBranchId: state.selectBranchId);
  }

  changeBranch(int shopId) {
    state = state.copyWith(changeBranchId: shopId);
  }

  setBranchId(BuildContext context, {int? shopId}) {
    int oldShopId = LocalStorage.instance.getShopId();
    if (oldShopId != (shopId ?? state.changeBranchId)) {
      AppHelpers.showAlertDialog(
          context: context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppHelpers.getTranslation(TrKeys.allPreviouslyAdded),
                style: Style.interNormal(),
                textAlign: TextAlign.center,
              ),
              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                        title: AppHelpers.getTranslation(TrKeys.cancel),
                        background: Style.transparent,
                        borderColor: Style.borderColor,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  10.horizontalSpace,
                  Expanded(child: Consumer(builder: (contextTwo, ref, child) {
                    return CustomButton(
                        isLoading: ref.watch(shopOrderProvider).isDeleteLoading,
                        title: AppHelpers.getTranslation(TrKeys.continueText),
                        onPressed: () {
                          ref
                              .read(shopOrderProvider.notifier)
                              .deleteCart(context)
                              .then((value) async {
                            context.popRoute();
                            LocalStorage.instance.deleteCartLocal();
                            LocalStorage.instance
                                .setShopId(shopId ?? state.changeBranchId);
                            state = state.copyWith(
                                selectBranchId: shopId ?? state.changeBranchId);
                            fetchProducts(context);
                            fetchProductsPopular(context);
                            fetchRecipeCategory(context);
                            fetchCategories(context);
                            fetchStore(context);
                            fetchBanner(context);
                          });
                        });
                  })),
                ],
              )
            ],
          ));
    }
  }

  changeFilter(String filter) {
    state = state.copyWith(shopFilter: filter);
  }

  Future<void> fetchBranchesFilter(
      BuildContext context, String filter, LatLng? latLng) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isBranchesLoading: true,
      );
      ApiResult<ShopsPaginateResponse>? response;
      if (filter == TrKeys.allShops) {
        response = await _shopsRepository.getAllShops(
          1,
          isOpen: true,
        );
      } else if (filter == TrKeys.nearYou) {
        response =
            await _shopsRepository.getAllShops(1, isOpen: true, latLng: latLng);
      } else if (filter == TrKeys.work247) {
        response =
            await _shopsRepository.getAllShops(1, isOpen: true, work24: true);
      } else if (filter == TrKeys.newShops) {
        response =
            await _shopsRepository.getAllShops(1, isOpen: true, newShop: true);
      }

      response?.when(
        success: (data) async {
          state = state.copyWith(
            isBranchesLoading: false,
            branches: data.data ?? [],
          );
          final ImageCropperForMarker image = ImageCropperForMarker();
          Set<Marker> list = {};
          for (int i = 0; i < (data.data?.length ?? 0); i++) {
            list.add(Marker(
                markerId: MarkerId(data.data?[i].id.toString() ?? ""),
                position: LatLng(
                  data.data?[i].location?.latitude ?? AppConstants.demoLatitude,
                  data.data?[i].location?.longitude ??
                      AppConstants.demoLongitude,
                ),
                infoWindow: InfoWindow(
                  title: data.data?[i].translation?.title?.toUpperCase(),
                ),
                icon: await image.resizeAndCircle(
                    data.data?[i].logoImg ?? "", 120)));
          }

          state = state.copyWith(shopMarkers: list);
        },
        failure: (failure, status) {
          state = state.copyWith(
            isBranchesLoading: false,
          );
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(
          context,
        );
      }
    }
  }

  Future<void> fetchBranches(BuildContext context, bool setDefault) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isBranchesLoading: true,
      );
      final response = await _shopsRepository.getAllShops(
        1,
        isOpen: true,
      );
      response.when(
        success: (data) async {
          if (setDefault) {
            LocalStorage.instance.setShopId(data.data?.first.id);
            state = state.copyWith(
              selectBranchId: data.data?.first.id ?? 0,
            );
            final response = await _productsRepository.getProductsPaginate(
                page: 1, shopId: data.data?.first.id ?? 0);
            response.when(
              success: (data) {
                state = state.copyWith(
                  products: data.data ?? [],
                  isProductLoading: false,
                );
              },
              failure: (failure, status) {
                state = state.copyWith(isProductLoading: false);
                AppHelpers.showCheckTopSnackBar(
                  context,
                  AppHelpers.getTranslation(failure.toString()),
                );
              },
            );
          }
          state = state.copyWith(
            isBranchesLoading: false,
            branches: data.data ?? [],
          );
          final ImageCropperForMarker image = ImageCropperForMarker();
          Set<Marker> list = {};
          for (int i = 0; i < (data.data?.length ?? 0); i++) {
            list.add(Marker(
                markerId: MarkerId(data.data?[i].id.toString() ?? ""),
                position: LatLng(
                  data.data?[i].location?.latitude ?? AppConstants.demoLatitude,
                  data.data?[i].location?.longitude ??
                      AppConstants.demoLongitude,
                ),
                infoWindow: InfoWindow(
                  title: data.data?[i].translation?.title?.toUpperCase(),
                ),
                icon: await image.resizeAndCircle(
                    data.data?[i].logoImg ?? "", 120)));
          }

          state = state.copyWith(shopMarkers: list);
        },
        failure: (failure, status) {
          state = state.copyWith(
            isBranchesLoading: false,
          );
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(
          context,
        );
      }
    }
  }

  Future<void> fetchCategories(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isCategoryLoading: true);
      final response = await _categoriesRepository.getAllCategories(page: 1);
      response.when(
        success: (data) async {
          state = state.copyWith(
            isCategoryLoading: false,
            categories: data.data ?? [],
          );
        },
        failure: (activeFailure, status) {
          state = state.copyWith(isCategoryLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(activeFailure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchBannerById(BuildContext context, int bannerId) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isBannerLoading: true);
      final response = await _bannersRepository.getBannerById(bannerId);
      response.when(
        success: (data) async {
          state = state.copyWith(
            isBannerLoading: false,
            banner: data,
          );
        },
        failure: (activeFailure, status) {
          state = state.copyWith(isBannerLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(activeFailure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchCategoriesPage(
      BuildContext context, RefreshController controller,
      {bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (isRefresh) {
        categoryIndex = 1;
      }
      final response = await _categoriesRepository.getAllCategories(
          page: isRefresh ? 1 : ++categoryIndex);
      response.when(
        success: (data) async {
          if (isRefresh) {
            state = state.copyWith(
              categories: data.data ?? [],
            );
            controller.refreshCompleted();
          } else {
            if (data.data?.isNotEmpty ?? false) {
              List<CategoryData> list = List.from(state.categories);
              list.addAll(data.data!);
              state = state.copyWith(
                categories: list,
              );
              controller.loadComplete();
            } else {
              categoryIndex--;
              controller.loadNoData();
            }
          }
        },
        failure: (activeFailure, status) {
          if (!isRefresh) {
            categoryIndex--;
            controller.loadNoData();
          } else {
            controller.refreshFailed();
          }
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(activeFailure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchStorePage(
      BuildContext context, RefreshController shopController,
      {bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (isRefresh) {
        storyIndex = 1;
      }
      final response =
          await _shopsRepository.getStory(isRefresh ? 1 : ++storyIndex);
      response.when(
        success: (data) async {
          if (isRefresh) {
            state = state.copyWith(
              story: data ?? [],
            );
            shopController.refreshCompleted();
          } else {
            if (data?.isNotEmpty ?? false) {
              List<List<StoryModel?>?>? list = state.story;
              list!.addAll(data!);
              state = state.copyWith(
                story: list,
              );
              shopController.loadComplete();
            } else {
              storyIndex--;

              shopController.loadNoData();
            }
          }
        },
        failure: (activeFailure, status) {
          if (!isRefresh) {
            storyIndex--;
            shopController.loadFailed();
          } else {
            shopController.refreshFailed();
          }
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(activeFailure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchStore(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isStoryLoading: true);
      final response = await _shopsRepository.getStory(1);
      response.when(
        success: (data) async {
          state = state.copyWith(isStoryLoading: false, story: data ?? []);
        },
        failure: (activeFailure, status) {
          state = state.copyWith(isStoryLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(activeFailure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchBanner(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isBannerLoading: true);
      final response = await _bannersRepository.getBannersPaginate(page: 1);
      response.when(
        success: (data) async {
          state =
              state.copyWith(isBannerLoading: false, banners: data.data ?? []);
        },
        failure: (activeFailure, status) {
          state = state.copyWith(isBannerLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(activeFailure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchBannerPage(
      BuildContext context, RefreshController controller,
      {bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (isRefresh) {
        bannerIndex = 1;
      }
      final response = await _bannersRepository.getBannersPaginate(
          page: isRefresh ? 1 : ++bannerIndex);
      response.when(
        success: (data) async {
          if (isRefresh) {
            state = state.copyWith(
              banners: data.data ?? [],
            );
            controller.refreshCompleted();
          } else {
            if (data.data?.isNotEmpty ?? false) {
              List<BannerData> list = List.from(state.banners);
              list.addAll(data.data!);
              state = state.copyWith(
                banners: list,
              );
              controller.loadComplete();
            } else {
              bannerIndex--;
              controller.loadNoData();
            }
          }
        },
        failure: (activeFailure, status) {
          if (!isRefresh) {
            bannerIndex--;
            controller.loadFailed();
          } else {
            controller.refreshFailed();
          }

          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(activeFailure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchFilterProducts(BuildContext context,
      {int? categoryId}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (categoryId == null) {
        state = state.copyWith(isSelectCategoryLoading: -1);
      } else {
        state = state.copyWith(filterProducts: []);
      }

      final response = await _productsRepository.getProductsByCategoryPaginate(
        categoryId:
            categoryId ?? state.categories[state.selectIndexCategory].id ?? 0,
        page: 1,
      );
      response.when(
        success: (data) async {
          if (categoryId == null) {
            state = state.copyWith(
                isSelectCategoryLoading: 1, filterProducts: data.data ?? []);
          } else {
            state = state.copyWith(filterProducts: data.data ?? []);
          }
        },
        failure: (activeFailure, status) {
          if (categoryId == null) {
            state = state.copyWith(isSelectCategoryLoading: 1);
          }

          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(activeFailure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchFilterProductsPage(
      BuildContext context, RefreshController productController,
      {bool isRefresh = false, int? categoryId}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (isRefresh) {
        productRefreshIndex = 1;
      }
      final response = await _productsRepository.getProductsByCategoryPaginate(
        categoryId:
            categoryId ?? state.categories[state.selectIndexCategory].id ?? 0,
        page: isRefresh ? 1 : ++productRefreshIndex,
      );
      response.when(
        success: (data) async {
          if (isRefresh) {
            state = state.copyWith(
              filterProducts: data.data ?? [],
            );
            productController.refreshCompleted();
          } else {
            if (data.data?.isNotEmpty ?? false) {
              List<ProductData> list = List.from(state.filterProducts);
              list.addAll(data.data!);
              state = state.copyWith(
                filterProducts: list,
              );
              productController.loadComplete();
            } else {
              productRefreshIndex--;
              productController.loadNoData();
            }
          }
        },
        failure: (activeFailure, status) {
          if (!isRefresh) {
            productRefreshIndex--;
            productController.loadFailed();
          } else {
            productController.refreshFailed();
          }
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(activeFailure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  Future<void> fetchProductsWithCheckBranch(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      marketRefreshIndex = 1;
      state = state.copyWith(
        isProductLoading: true,
      );
      final res = await _shopsRepository.getNearbyShop();
      res.when(success: (shop) async {
        LocalStorage.instance.setShopId(shop.data?.id);
        state = state.copyWith(
          selectBranchId: shop.data?.id ?? 0,
        );
        final response = await _productsRepository.getNewProductsPaginate(
            page: 1, shopId: shop.data?.id);
        response.when(
          success: (data) {
            state = state.copyWith(
              allProducts: data.data ?? [],
              isProductLoading: false,
            );
          },
          failure: (failure, status) {
            state = state.copyWith(isProductLoading: false);
            AppHelpers.showCheckTopSnackBar(
              context,
              AppHelpers.getTranslation(failure.toString()),
            );
          },
        );
      }, failure: (failure, status) {
        fetchBranches(context, true);
        state = state.copyWith(isProductLoading: false);
      });
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(
          context,
        );
      }
    }
  }

  Future<void> fetchProducts(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      marketRefreshIndex = 1;
      state = state.copyWith(
        isProductLoading: true,
      );
      final response = await _productsRepository.getNewProductsPaginate(
          page: 1, shopId: state.selectBranchId);
      response.when(
        success: (data) {
          state = state.copyWith(
            allProducts: data.data ?? [],
            isProductLoading: false,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isProductLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(
          context,
        );
      }
    }
  }

  Future<void> fetchProductsPage(
      BuildContext context, RefreshController productController,
      {bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (isRefresh) {
        marketRefreshIndex = 0;
      }
      final response = await _productsRepository.getNewProductsPaginate(
          page: ++marketRefreshIndex, shopId: state.selectBranchId);
      response.when(
        success: (data) {
          if (isRefresh) {
            state = state.copyWith(
              allProducts: data.data ?? [],
            );
            productController.refreshCompleted();
          } else {
            if (data.data?.isNotEmpty ?? false) {
              List<AllModel> list = List.from(state.allProducts);
              list.addAll(data.data ?? []);
              state = state.copyWith(
                allProducts: list,
                isProductLoading: false,
              );
              productController.loadComplete();
            } else {
              marketRefreshIndex--;
              productController.loadNoData();
            }
          }
        },
        failure: (failure, status) {
          if (!isRefresh) {
            marketRefreshIndex--;
            productController.loadFailed();
          } else {
            productController.refreshFailed();
          }
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(
          context,
        );
      }
    }
  }

  Future<void> fetchProductsPopular(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      productPopularRefreshIndex = 1;
      state = state.copyWith(
        isProductPopularLoading: true,
      );
      final response = await _productsRepository.getProductsPopularPaginate(
          page: 1, shopId: LocalStorage.instance.getShopId());
      response.when(
        success: (data) {
          state = state.copyWith(
            productsPopular: data.data ?? [],
            isProductPopularLoading: false,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isProductPopularLoading: false);
          if (status != 404) {
            AppHelpers.showCheckTopSnackBar(
              context,
              AppHelpers.getTranslation(failure.toString()),
            );
          }
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(
          context,
        );
      }
    }
  }

  Future<void> fetchProductsPopularPage(
      BuildContext context, RefreshController productController,
      {bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (isRefresh) {
        productPopularRefreshIndex = 0;
      }
      final response = await _productsRepository.getProductsPopularPaginate(
          page: ++productPopularRefreshIndex);
      response.when(
        success: (data) {
          if (isRefresh) {
            state = state.copyWith(
              productsPopular: data.data ?? [],
            );
            productController.refreshCompleted();
          } else {
            if (data.data?.isNotEmpty ?? false) {
              List<ProductData> list = List.from(state.productsPopular);
              list.addAll(data.data!.toList());
              state = state.copyWith(
                productsPopular: list,
                isProductPopularLoading: false,
              );
              productController.loadComplete();
            } else {
              productPopularRefreshIndex--;
              productController.loadNoData();
            }
          }
        },
        failure: (failure, status) {
          if (!isRefresh) {
            productPopularRefreshIndex--;
            productController.loadFailed();
          } else {
            productController.refreshFailed();
          }
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(
          context,
        );
      }
    }
  }

  Future<void> fetchRecipeCategory(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      recipeCategoryRefreshIndex = 1;
      state = state.copyWith(
        isRecipesLoading: true,
      );
      final response = await _productsRepository.getRecipeCategoriesPaginate(
        page: 1,
      );
      response.when(
        success: (data) {
          state = state.copyWith(
            recipesCategory: data.data ?? [],
            isRecipesLoading: false,
          );
        },
        failure: (failure, status) {
          state = state.copyWith(isRecipesLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(
          context,
        );
      }
    }
  }

  Future<void> fetchRecipeCategoryPage(
      BuildContext context, RefreshController productController,
      {bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (isRefresh) {
        recipeCategoryRefreshIndex = 0;
      }
      final response = await _productsRepository.getRecipeCategoriesPaginate(
          page: ++recipeCategoryRefreshIndex);
      response.when(
        success: (data) {
          if (isRefresh) {
            state = state.copyWith(
              recipesCategory: data.data ?? [],
            );
            productController.refreshCompleted();
          } else {
            if (data.data?.isNotEmpty ?? false) {
              List<CategoryData> list = List.from(state.recipesCategory);
              list.addAll(data.data!.toList());
              state = state.copyWith(
                recipesCategory: list,
              );
              productController.loadComplete();
            } else {
              recipeCategoryRefreshIndex--;
              productController.loadNoData();
            }
          }
        },
        failure: (failure, status) {
          if (!isRefresh) {
            recipeCategoryRefreshIndex--;
            productController.loadFailed();
          } else {
            productController.refreshFailed();
          }
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(failure.toString()),
          );
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(
          context,
        );
      }
    }
  }
}

