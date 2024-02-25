
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoppingapp/infrastructure/models/data/filter_model.dart';
import 'package:shoppingapp/infrastructure/models/data/product_data.dart';
import 'package:shoppingapp/infrastructure/models/data/take_data.dart';

import '../../infrastructure/models/data/shop_data.dart';
part 'filter_state.freezed.dart';

@freezed
class FilterState with _$FilterState {

  const factory FilterState({
    @Default(null) FilterModel? filterModel,
    @Default(false) bool freeDelivery,
    @Default(false) bool deals,
    @Default(true) bool open,
    @Default(0) int shopCount,
    @Default(100) double endPrice,
    @Default(false) bool isLoading,
    @Default(false) bool isTagLoading,
    @Default(true) bool isShopLoading,
    @Default(true) bool isProductLoading,
    @Default(RangeValues(1, 100)) RangeValues rangeValues,
    @Default([]) List<ShopData> shops,
    @Default([]) List<TakeModel> tags,
    @Default([]) List<int> prices,
    @Default([]) List<ProductData> products,

  }) = _FilterState;

  const FilterState._();
}