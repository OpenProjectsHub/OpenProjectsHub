import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/iterface/products.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';

import 'like_state.dart';

class LikeNotifier extends StateNotifier<LikeState> {
  final ProductsRepositoryFacade _productsRepository;

  LikeNotifier(
    this._productsRepository,
  ) : super(const LikeState());

  Future<void> fetchLikeProducts(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isProductLoading: true);
      final list = LocalStorage.instance.getSavedProductsList();
      if (list.isNotEmpty) {
        final response = await _productsRepository.getProductsByIds(list);
        response.when(
          success: (data) async {
            state =
                state.copyWith(isProductLoading: false, products: data.data ?? []);
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
        state = state.copyWith(isProductLoading: false, products: []);
      }
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }
}
