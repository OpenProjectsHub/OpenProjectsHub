import 'package:freezed_annotation/freezed_annotation.dart';
part 'add_card_state.freezed.dart';

@freezed
class AddCardState with _$AddCardState {
  const factory AddCardState({
    @Default(false) bool isActiveCard,
    @Default("0000 0000 0000 0000") String cardNumber,
    @Default("") String cardName,
    @Default("") String date,
    @Default("") String cvc,

  }) = _AddCardState;

  const AddCardState._();
}
