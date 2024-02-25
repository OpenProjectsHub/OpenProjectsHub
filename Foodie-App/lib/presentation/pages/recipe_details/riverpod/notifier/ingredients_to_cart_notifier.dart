import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/iterface/cart.dart';
import 'package:shoppingapp/infrastructure/models/data/product_data.dart';
import 'package:shoppingapp/infrastructure/models/request/cart_request.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';

import '../state/ingredients_to_cart_state.dart';

class IngredientsToCartNotifier extends StateNotifier<IngredientsToCartState> {
  final CartRepositoryFacade _cartsRepository;

  IngredientsToCartNotifier(this._cartsRepository)
      : super(const IngredientsToCartState());

  void addedProducts(bool value) {
    state = state.copyWith(added: value);
  }

  Future<void> insertProducts({
    int? shopId,
    List<Stocks>? products,
    VoidCallback? checkYourNetwork,
    VoidCallback? success,
  }) async {
    if (await AppConnectivity.connectivity()) {
      state = state.copyWith(isLoading: true);

      List<CartRequest> list = [];
      products?.forEach((element) {
        list.add(CartRequest(stockId: element.id, quantity: element.quantity));
      });
      final response = await _cartsRepository.insertCart(
        cart: CartRequest(carts: list,shopId: LocalStorage.instance.getShopId()
        ),
      );
      response.when(
        success: (data) {
          state = state.copyWith(isLoading: false, added: true);
          success?.call();
        },
        failure: (failure, s) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> insert products failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}
