
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
part 'like_state.freezed.dart';

@freezed
class LikeState with _$LikeState {

  const factory LikeState({
    @Default(true) bool isProductLoading,
    @Default([]) List<ProductData> products,

  }) = _LikeState;

  const LikeState._();
}