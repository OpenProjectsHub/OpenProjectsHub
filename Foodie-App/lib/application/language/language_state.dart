
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';

part 'language_state.freezed.dart';

@freezed
class LanguageState with _$LanguageState {

  const factory LanguageState({
    @Default([]) List<LanguageData> list,
    @Default(0) int index,
    @Default(true) bool isLoading,
    @Default(false) bool isSuccess

  }) = _LanguageState;

  const LanguageState._();
}