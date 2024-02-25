import 'package:freezed_annotation/freezed_annotation.dart';

part 'promo_code_state.freezed.dart';

@freezed
class PromoCodeState with _$PromoCodeState {
  const factory PromoCodeState({
    @Default(false) bool isActive,
    @Default(false) bool isLoading,
  }) = _PromoCodeState;

  const PromoCodeState._();
}
