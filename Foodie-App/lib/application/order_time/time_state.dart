
import 'package:freezed_annotation/freezed_annotation.dart';


part 'time_state.freezed.dart';

@freezed
class TimeState with _$TimeState {

  const factory TimeState({
    @Default(0) int currentIndexOne,
    @Default(0) int currentIndexTwo,
    @Default(null) int? selectIndex,
  }) = _TimeState;

  const TimeState._();
}