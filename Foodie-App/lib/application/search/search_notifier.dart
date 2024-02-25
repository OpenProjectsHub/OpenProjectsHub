import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/iterface/products.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';

import 'search_state.dart';

class SearchNotifier extends StateNotifier<SearchState> {

  final ProductsRepositoryFacade _productsRepository;

  SearchNotifier(this._productsRepository)
      : super(const SearchState());
  int productIndex = 1;

  init() {
    List<String> list = LocalStorage.instance.getSearchList();
    state = state.copyWith(searchHistory: list);
  }

  void setSelectCategory(int index, BuildContext context,{int? categoryId}) {
    if (state.selectIndexCategory == index) {
      state = state.copyWith(
        selectIndexCategory: -1,
      );
    } else {
      state = state.copyWith(
        selectIndexCategory: index,
      );
    }
    if(state.search.isNotEmpty){
      searchProduct(context,state.search, categoryId: state.selectIndexCategory < 0 ? null : categoryId);
    }
  }

  void changeSearch(String text) async {
    List<String> list = List.from(state.searchHistory);
    if (text.isNotEmpty && !list.contains(text)) {
      list.add(text);
    }
    state = state.copyWith(search: text, searchHistory: list);
    LocalStorage.instance.setSearchHistory(list);
  }

  void clearAllHistory() {
    state = state.copyWith(searchHistory: []);
    LocalStorage.instance.deleteSearchList();
  }

  void clearHistory(int index) {
    List<String> list = List.from(state.searchHistory);
    list.removeAt(index);
    state = state.copyWith(searchHistory: list);
    LocalStorage.instance.setSearchHistory(list);
  }


  Future<void> searchProduct(BuildContext context, String text,{int? categoryId}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isProductLoading: true);
      final response = await _productsRepository.searchProducts(text: text,categoryId: categoryId);
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

  Future<void> searchProductPage(BuildContext context, String text,{int? categoryId}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      final response = await _productsRepository.searchProducts(
          text: text, page: ++productIndex,categoryId: categoryId);
      response.when(
        success: (data) async {
          if (data.data != null) {
            List<ProductData> list = List.from(state.products);
            list.addAll(data.data!);
            state = state.copyWith(
              products: list,
            );
          } else {
            productIndex--;
          }
        },
        failure: (activeFailure, status) {
          productIndex--;
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
