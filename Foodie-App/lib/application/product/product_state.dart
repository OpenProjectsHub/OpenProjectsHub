
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';


part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {

  const factory ProductState({
    @Default(false) bool isLoading,
    @Default(false) bool isAddLoading,
    @Default(false) bool isShareLoading,
    @Default(false) bool isCheckShopOrder,
    @Default(false) bool isLike,
    @Default(0) int currentIndex,
    @Default(1) int count,
    @Default(0) int stockCount,
    @Default([]) List<TypedExtra> typedExtras,
    @Default([]) List<Stocks> initialStocks,
    @Default([]) List<int> selectedIndexes,
    @Default('') String activeImageUrl,
    @Default(null) ProductData? productData,
    Stocks? selectedStock,

  }) = _ProductState;

  const ProductState._();
}