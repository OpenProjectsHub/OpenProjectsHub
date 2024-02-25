// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:shoppingapp/application/shop_order/shop_order_provider.dart';
import 'package:shoppingapp/domain/iterface/products.dart';
import 'package:shoppingapp/infrastructure/models/data/addons_data.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import 'package:shoppingapp/infrastructure/services/app_connectivity.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import '../../domain/iterface/cart.dart';
import '../../infrastructure/models/request/cart_request.dart';
import '../../infrastructure/services/app_constants.dart';
import '../../presentation/theme/app_style.dart';
import 'product_state.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRepositoryFacade _productsRepository;
  final CartRepositoryFacade _cartRepository;

  ProductNotifier(this._cartRepository, this._productsRepository)
      : super(const ProductState());
  String? shareLink;
  List<int> _list = [];

  void change(int index) {
    state = state.copyWith(currentIndex: index);
  }

  void onLike() {
    if (state.isLike) {
      for (int i = 0; i < _list.length; i++) {
        if (_list[i] == state.productData?.id) {
          _list.removeAt(i);
          break;
        }
      }
    } else {
      _list.add(state.productData?.id ?? 0);
    }
    state = state.copyWith(isLike: !state.isLike);
    LocalStorage.instance.setSavedProductsList(_list);
  }

  Future<void> getProductDetails(
    BuildContext context,
    ProductData productData,
    String? shopType,
    int? shopId,
  ) async {
    _list = LocalStorage.instance.getSavedProductsList();

    for (int e in _list) {
      if (e == productData.id) {
        state = state.copyWith(
          isLike: true,
        );
        break;
      }
    }
    final List<Stocks> stocks = productData.stocks ?? <Stocks>[];
    state = state.copyWith(
      count: productData.minQty ?? 1,
      isCheckShopOrder: false,
      productData: productData,
      activeImageUrl: '${productData.img}',
      initialStocks: stocks,
      isLoading: true,
    );
    generateShareLink(shopType, shopId);
    if (stocks.isNotEmpty) {
      final int groupsCount = stocks[0].extras?.length ?? 0;
      final List<int> selectedIndexes = List.filled(groupsCount, 0);
      initialSetSelectedIndexes(context, selectedIndexes);
    }
    final response = await _productsRepository.getProductDetails(productData.uuid.toString());
    response.when(
      success: (data) async {
        final List<Stocks> stocks = data.data?.stocks ?? <Stocks>[];
        state = state.copyWith(
          count: data.data?.minQty ?? 1,
          productData: data.data,
          activeImageUrl: '${data.data?.img}',
          initialStocks: stocks,
          isLoading: false,
        );
        if (stocks.isNotEmpty) {
          final int groupsCount = stocks[0].extras?.length ?? 0;
          final List<int> selectedIndexes = List.filled(groupsCount, 0);
          initialSetSelectedIndexes(context, selectedIndexes);
        }
      },
      failure: (failure, s) {
        state = state.copyWith(isLoading: false);
        AppHelpers.showCheckTopSnackBar(
          context,
          AppHelpers.getTranslation(s.toString()),
        );
        debugPrint('==> get product details failure: $failure');
      },
    );
  }

  Future<void> getProductDetailsById(
    BuildContext context,
    String productId,
    String? shopType,
    int? shopId,
  ) async {
    _list = LocalStorage.instance.getSavedProductsList();
    for (int e in _list) {
      if (e == int.tryParse(productId)) {
        state = state.copyWith(
          isLike: true,
        );
        break;
      }
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isLoading: true,
        productData: null,
        activeImageUrl: '',
      );
      final response = await _productsRepository.getProductDetails(productId);
      response.when(
        success: (data) async {
          final List<Stocks> stocks = data.data?.stocks ?? <Stocks>[];
          state = state.copyWith(
            count: data.data?.minQty ?? 1,
            productData: data.data,
            activeImageUrl: '${data.data?.img}',
            initialStocks: stocks,
            isLoading: false,
          );
          generateShareLink(shopType, shopId);
          if (stocks.isNotEmpty) {
            final int groupsCount = stocks[0].extras?.length ?? 0;
            final List<int> selectedIndexes = List.filled(groupsCount, 0);
            initialSetSelectedIndexes(context, selectedIndexes);
          }
        },
        failure: (failure, s) {
          state = state.copyWith(isLoading: false);
          AppHelpers.showCheckTopSnackBar(
            context,
            AppHelpers.getTranslation(s.toString()),
          );
          debugPrint('==> get product details failure: $failure');
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showCheckTopSnackBar(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      }
    }
  }

  void addCount(BuildContext context) {
    int count = state.count;
    if (count < (state.productData?.maxQty ?? 1)) {
      state = state.copyWith(count: ++count);
    } else {
      AppHelpers.showCheckTopSnackBarInfo(context,
          "${AppHelpers.getTranslation(TrKeys.maxQty)} ${state.count}");
    }
  }

  void disCount(BuildContext context) {
    int count = state.count;
    if (count > (state.productData?.minQty ?? 1)) {
      state = state.copyWith(count: --count);
    } else {
      AppHelpers.showCheckTopSnackBarInfo(
          context, AppHelpers.getTranslation(TrKeys.minQty));
    }
  }

  void createCart(BuildContext context, int shopId, VoidCallback onSuccess,
      {int? stockId,
      int? count,
      VoidCallback? onError,
      ProductData? product}) async {
    state = state.copyWith(isCheckShopOrder: false);

    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isAddLoading: true,);
      dynamic response;
      if (product == null) {
        List<CartRequest> list = [
          CartRequest(
              stockId: stockId ?? state.selectedStock?.id ?? 0,
              quantity: count ?? state.count)
        ];
        for (Addons element in state.selectedStock?.addons ?? []) {
          list.add(
            CartRequest(
                stockId: element.product?.stock?.id,
                quantity: (element.active ?? false) ? element.quantity : 0,
                parentId: stockId ?? state.selectedStock?.id ?? 0),
          );
        }
        response = await _cartRepository.insertCart(
          cart: CartRequest(
              shopId: state.productData?.shopId ?? 0,
              stockId: stockId ?? state.selectedStock?.id ?? 0,
              quantity: count ?? state.count,
              carts: list.isNotEmpty ? list : null),
        );
      } else {
        List<CartRequest> list = [
          CartRequest(stockId: product.stock?.id, quantity: 1)
        ];
        response = await _cartRepository.insertCart(
          cart: CartRequest(
              shopId: product.shopId ?? 0,
              stockId: product.id ?? 0,
              quantity: product.count,
              carts: list),
        );
      }

      response.when(
        success: (data) {
          if (mounted) {
            state = state.copyWith(isAddLoading: false);
          }

          onSuccess();
        },
        failure: (activeFailure, status) {
          if (status != 400) {
            if (mounted) {
              state = state.copyWith(isAddLoading: false);
            }

            AppHelpers.showCheckTopSnackBar(
              context,
              AppHelpers.getTranslation(activeFailure.toString()),
            );
          } else if (status == 400) {
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
                        Expanded(
                            child: Consumer(builder: (contextTwo, ref, child) {
                          return CustomButton(
                              isLoading:
                                  ref.watch(shopOrderProvider).isDeleteLoading,
                              title: AppHelpers.getTranslation(
                                  TrKeys.continueText),
                              onPressed: () {
                                ref
                                    .read(shopOrderProvider.notifier)
                                    .deleteCart(context)
                                    .then((value) async {
                                  createCart(
                                      context,
                                      ref
                                              .watch(shopOrderProvider)
                                              .cart
                                              ?.shopId ??
                                          (state.productData!.shopId ?? 0), () {
                                    ref
                                        .read(shopOrderProvider.notifier)
                                        .getCart(context, () {});
                                    Navigator.pop(context);
                                  });
                                });
                              });
                        })),
                      ],
                    )
                  ],
                ));
          } else {
            onError?.call();
          }
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }

  void updateSelectedIndexes(BuildContext context, int index, int value) {
    final newList = state.selectedIndexes.sublist(0, index);
    newList.add(value);
    final postList =
        List.filled(state.selectedIndexes.length - newList.length, 0);
    newList.addAll(postList);
    initialSetSelectedIndexes(context, newList);
  }

  void initialSetSelectedIndexes(BuildContext context, List<int> indexes) {
    state = state.copyWith(selectedIndexes: indexes);
    updateExtras(context);
  }

  void updateExtras(BuildContext context) {
    final int groupsCount = state.initialStocks[0].extras?.length ?? 0;
    final List<TypedExtra> groupExtras = [];
    for (int i = 0; i < groupsCount; i++) {
      if (i == 0) {
        final TypedExtra extras = getFirstExtras(state.selectedIndexes[0]);
        groupExtras.add(extras);
      } else {
        final TypedExtra extras =
            getUniqueExtras(groupExtras, state.selectedIndexes, i);
        groupExtras.add(extras);
      }
    }
    final Stocks? selectedStock = getSelectedStock(groupExtras);
    int stockCount = 0;
    state = state.copyWith(
      typedExtras: groupExtras,
      selectedStock: selectedStock,
      stockCount: stockCount,
    );
  }

  void updateIngredient(BuildContext context, int selectIndex) {
    List<Addons>? data = state.selectedStock?.addons;
    data?[selectIndex].active = !(data[selectIndex].active ?? false);
    List<Stocks>? stocks = state.productData?.stocks;
    Stocks? newStock = stocks?.first.copyWith(addons: data);
    ProductData? product = state.productData;
    ProductData? newProduct = product?.copyWith(stocks: [newStock!]);
    state = state.copyWith(productData: newProduct);
  }

  void addIngredient(
    BuildContext context,
    int selectIndex,
  ) {
    if ((state.selectedStock?.addons?[selectIndex].product?.maxQty ?? 0) >
            (state.selectedStock?.addons?[selectIndex].quantity ?? 0) &&
        (state.selectedStock?.addons?[selectIndex].product?.stock?.quantity ??
                0) >
            (state.selectedStock?.addons?[selectIndex].quantity ?? 0)) {
      List<Addons>? data = state.selectedStock?.addons;
      data?[selectIndex].quantity = (data[selectIndex].quantity ?? 0) + 1;
      List<Stocks>? stocks = state.productData?.stocks;
      Stocks? newStock = stocks?.first.copyWith(addons: data);
      ProductData? product = state.productData;
      ProductData? newProduct = product?.copyWith(stocks: [newStock!]);
      state = state.copyWith(productData: newProduct);
    } else {
      AppHelpers.showCheckTopSnackBarInfo(context,
          "${AppHelpers.getTranslation(TrKeys.maxQty)} ${state.selectedStock?.addons?[selectIndex].quantity ?? 1}");
    }
  }

  void removeIngredient(BuildContext context, int selectIndex) {
    if ((state.selectedStock?.addons?[selectIndex].product?.minQty ?? 0) <
        (state.selectedStock?.addons?[selectIndex].quantity ?? 0)) {
      List<Addons>? data = state.selectedStock?.addons;
      data?[selectIndex].quantity = (data[selectIndex].quantity ?? 0) - 1;
      List<Stocks>? stocks = state.productData?.stocks;
      Stocks? newStock = stocks?.first.copyWith(addons: data);
      ProductData? product = state.productData;
      ProductData? newProduct = product?.copyWith(stocks: [newStock!]);
      state = state.copyWith(productData: newProduct);
    } else {
      AppHelpers.showCheckTopSnackBarInfo(
          context, AppHelpers.getTranslation(TrKeys.minQty));
    }
  }

  Stocks? getSelectedStock(List<TypedExtra> groupExtras) {
    List<Stocks> stocks = List.from(state.initialStocks);
    for (int i = 0; i < groupExtras.length; i++) {
      String selectedExtrasValue =
          groupExtras[i].uiExtras[state.selectedIndexes[i]].value;
      stocks = getSelectedStocks(stocks, selectedExtrasValue, i);
    }
    return stocks[0];
  }

  List<Stocks> getSelectedStocks(List<Stocks> stocks, String value, int index) {
    List<Stocks> included = [];
    for (int i = 0; i < stocks.length; i++) {
      if (stocks[i].extras?[index].value == value) {
        included.add(stocks[i]);
      }
    }
    return included;
  }

  TypedExtra getFirstExtras(int selectedIndex) {
    ExtrasType type = ExtrasType.text;
    String title = '';
    final List<String> uniques = [];
    for (int i = 0; i < state.initialStocks.length; i++) {
      uniques.add(state.initialStocks[i].extras?[0].value ?? '');
      title = state.initialStocks[i].extras?[0].group?.translation?.title ?? '';
      type = AppHelpers.getExtraTypeByValue(
          state.initialStocks[i].extras?[0].group?.type);
    }
    final setOfUniques = uniques.toSet().toList();
    final List<UiExtra> extras = [];
    for (int i = 0; i < setOfUniques.length; i++) {
      if (selectedIndex == i) {
        extras.add(UiExtra(
          setOfUniques[i],
          true,
          i,
        ));
      } else {
        extras.add(UiExtra(setOfUniques[i], false, i));
      }
    }
    return TypedExtra(type, extras, title, 0);
  }

  TypedExtra getUniqueExtras(
    List<TypedExtra> groupExtras,
    List<int> selectedIndexes,
    int index,
  ) {
    List<Stocks> includedStocks = List.from(state.initialStocks);
    for (int i = 0; i < groupExtras.length; i++) {
      final String includedValue =
          groupExtras[i].uiExtras[selectedIndexes[i]].value;
      includedStocks = getIncludedStocks(includedStocks, i, includedValue);
    }
    final List<String> uniques = [];
    String title = '';
    ExtrasType type = ExtrasType.text;
    for (int i = 0; i < includedStocks.length; i++) {
      uniques.add(includedStocks[i].extras?[index].value ?? '');
      title = includedStocks[i].extras?[index].group?.translation?.title ?? '';
      type = AppHelpers.getExtraTypeByValue(
          includedStocks[i].extras?[index].group?.type ?? '');
    }
    final setOfUniques = uniques.toSet().toList();
    final List<UiExtra> extras = [];
    for (int i = 0; i < setOfUniques.length; i++) {
      if (selectedIndexes[groupExtras.length] == i) {
        extras.add(UiExtra(setOfUniques[i], true, i));
      } else {
        extras.add(UiExtra(setOfUniques[i], false, i));
      }
    }
    return TypedExtra(type, extras, title, index);
  }

  List<Stocks> getIncludedStocks(
    List<Stocks> includedStocks,
    int index,
    String includedValue,
  ) {
    List<Stocks> stocks = [];
    for (int i = 0; i < includedStocks.length; i++) {
      if (includedStocks[i].extras?[index].value == includedValue) {
        stocks.add(includedStocks[i]);
      }
    }
    return stocks;
  }

  void changeActiveImageUrl(String url) {
    state = state.copyWith(activeImageUrl: url);
  }

  generateShareLink(String? shopType, int? shopId) async {
    try{
      final productLink =
          '${AppConstants.webUrl}/$shopType/$shopId?product=${state.productData?.uuid}/';

      const dynamicLink =
          'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=${AppConstants.firebaseWebKey}';

      final dataShare = {
        "dynamicLinkInfo": {
          "domainUriPrefix": AppConstants.dynamicPrefix,
          "link": productLink,
          "androidInfo": {
            "androidPackageName": 'com.foodie.app',
            "androidFallbackLink":
            "${AppConstants.webUrl}/$shopType/$shopId?product=${state.productData?.uuid}"
          },
          "iosInfo": {
            "iosBundleId": "com.foodie.app",
            "iosFallbackLink":
            "${AppConstants.webUrl}/$shopType/$shopId?product=${state.productData?.uuid}"
          },
          "socialMetaTagInfo": {
            "socialTitle": "${state.productData?.translation?.title}",
            "socialDescription": "${state.productData?.translation?.description}",
            "socialImageLink": '${state.productData?.img}',
          }
        }
      };

      final res =
      await http.post(Uri.parse(dynamicLink), body: jsonEncode(dataShare));
      shareLink = jsonDecode(res.body)['shortLink'];

    // ignore: empty_catches
    }catch(e){

    }

  }

  Future shareProduct() async {
    await FlutterShare.share(
      text: state.productData?.translation?.title ?? "Foodie",
      title: state.productData?.translation?.description ?? "",
      linkUrl: shareLink,
    );
  }
}
