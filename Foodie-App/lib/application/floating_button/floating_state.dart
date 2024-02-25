
import 'package:freezed_annotation/freezed_annotation.dart';

part 'floating_state.freezed.dart';

@freezed
class FloatingState with _$FloatingState {

  const factory FloatingState({
    @Default(false) bool isScrolling,
  }) = _FloatingState;

  const FloatingState._();
}