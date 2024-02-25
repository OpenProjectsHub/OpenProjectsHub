import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/domain/iterface/products.dart';
import 'package:shoppingapp/domain/iterface/shops.dart';
import 'package:shoppingapp/infrastructure/models/data/filter_model.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tpying_delay.dart';

import '../../infrastructure/services/app_connectivity.dart';
import '../../infrastructure/services/app_helpers.dart';
import 'filter_state.dart';

class FilterNotifier extends StateNotifier<FilterState> {
  final ProductsRepositoryFacade _productsRepository;
  final ShopsRepositoryFacade _shopsRepository;

  FilterNotifier(this._productsRepository, this._shopsRepository)
      : super(const FilterState());
  int shopIndex = 1;
  int marketRefreshIndex = 1;
  final _delayed = Delayed(milliseconds: 700);

  Future<void> setFilterModel(BuildContext context, FilterModel? data) async {
    state = state.copyWith(filterModel: data);
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _productsRepository.getProductsPaginate(
          filterModel: data, page: 1);
      response.when(
        success: (data) async {
          state = state.copyWith(
              isLoading: false, shopCount: data.meta?.total ?? 0);
        },
        failure: (activeFailure, status) {
          state = state.copyWith(isLoading: false);
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

  void clear(BuildContext context) {
    state = state.copyWith(
        filterModel: FilterModel(),
        rangeValues: RangeValues(1, state.endPrice));
    setCheck(context, false);
  }

  Future<void> setCheck(BuildContext context, bool deal) async {
    state.filterModel?.isDeal = deal;

    state = state.copyWith(
      deals: deal,
    );
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _productsRepository.getProductsPaginate(
        shopId: LocalStorage.instance.getShopId(),
        page: 1,
        filterModel: state.filterModel,
      );
      response.when(
        success: (data) async {
          state = state.copyWith(
              isLoading: false, shopCount: data.meta?.total ?? 0);
        },
        failure: (activeFailure, status) {
          state = state.copyWith(isLoading: false);
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

  void setRange(RangeValues values, BuildContext context) {
    state.filterModel?.price = [values.start, values.end];
    state = state.copyWith(
        rangeValues: RangeValues(values.start, values.end),
        filterModel: state.filterModel);
    _delayed.run(() {
      setCheck(
        context,
        state.deals,
      );
    });
  }

  Future<void> init(BuildContext context) async {
    state = state.copyWith(filterModel: FilterModel(), isTagLoading: true);
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      final res = await _shopsRepository.getSuggestPrice();

      res.when(
        success: (data) async {
          state = state.copyWith(
              isTagLoading: false,
              endPrice: data.data.max,
              rangeValues: RangeValues(1, data.data.max - data.data.max / 15),
              prices: List.generate(
                  (15).round(), (index) => (Random().nextInt(8) + 1)));
        },
        failure: (activeFailure, status) {
          state = state.copyWith(isTagLoading: false);
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

  Future<void> fetchProduct(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isProductLoading: true);
      final response = await _productsRepository.getProductsPaginate(
          filterModel: state.filterModel, page: 1,shopId: LocalStorage.instance.getShopId(),);
      response.when(
        success: (data) async {
          state = state.copyWith(
              isProductLoading: false, products: data.data ?? []);
        },
        failure: (activeFailure, status) {
          state = state.copyWith(isProductLoading: false);
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

  Future<void> fetchRestaurantPage(
      BuildContext context, RefreshController shopController,
      {bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (isRefresh) {
        shopIndex = 0;
      }
      final response = await _productsRepository.getProductsPaginate(
          filterModel: state.filterModel, page: ++shopIndex,shopId: LocalStorage.instance.getShopId(),);
      response.when(
        success: (data) async {
          if (isRefresh) {
            state = state.copyWith(
              products: data.data ?? [],
            );
            shopController.refreshCompleted();
          } else {
            if (data.data?.isNotEmpty ?? false) {
              List<ProductData> list = List.from(state.products);
              list.addAll(data.data!);
              state = state.copyWith(
                products: list,
              );
              shopController.loadComplete();
            } else {
              shopIndex--;

              shopController.loadNoData();
            }
          }
        },
        failure: (activeFailure, status) {
          if (!isRefresh) {
            shopIndex--;
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

}
