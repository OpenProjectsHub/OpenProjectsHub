
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';


part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {

  const factory SearchState({
    @Default(true) bool isProductLoading,
    @Default("") String search,
    @Default([]) List<ProductData> products,
    @Default(-1) int selectIndexCategory,
    @Default([]) List<String> searchHistory,
  }) = _SearchState;

  const SearchState._();
}