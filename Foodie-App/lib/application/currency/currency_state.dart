
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
part 'currency_state.freezed.dart';

@freezed
class CurrencyState with _$CurrencyState {

  const factory CurrencyState({
    @Default([]) List<CurrencyData> list,
    @Default(true) bool isLoading,
    @Default(0) int index

  }) = _CurrencyState;

  const CurrencyState._();
}