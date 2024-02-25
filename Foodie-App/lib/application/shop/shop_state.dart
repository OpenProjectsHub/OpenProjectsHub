
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import 'package:shoppingapp/infrastructure/models/response/Galleries_response.dart';
import 'package:shoppingapp/infrastructure/models/response/review_count.dart';
import 'package:shoppingapp/infrastructure/models/response/review_response.dart';

part 'shop_state.freezed.dart';

@freezed
class ShopState with _$ShopState {

  const factory ShopState({
    @Default(false) bool isLoading,
    @Default(true) bool isCategoryLoading,
    @Default(true) bool isPopularLoading,
    @Default(true) bool isProductLoading,
    @Default(true) bool isProductPageLoading,
    @Default(false) bool isPopularProduct,
    @Default(false) bool isLike,
    @Default(false) bool showWeekTime,
    @Default(false) bool isMapLoading,
    @Default(false) bool isGroupOrder,
    @Default(false) bool isTodayWorkingDay,
    @Default(false) bool isTomorrowWorkingDay,
    @Default(TimeOfDay(hour: 0, minute: 0)) TimeOfDay startTodayTime,
    @Default(TimeOfDay(hour: 0, minute: 0)) TimeOfDay endTodayTime,
    @Default(0) int currentIndex,
    @Default({}) Set<Marker> shopMarkers,
    @Default([]) List<LatLng> polylineCoordinates,
    @Default([]) List<ReviewModel> reviews,
    @Default(null) ShopData? shopData,
    @Default(null) GalleriesModel? galleries,
    @Default(null) ReviewCountModel? reviewCount,
    @Default([]) List<ProductData> products,
    @Default([]) List<CategoryData>? category,
  }) = _ShopState;

  const ShopState._();
}