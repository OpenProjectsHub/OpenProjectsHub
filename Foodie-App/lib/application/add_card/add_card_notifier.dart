import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_card_state.dart';

class AddCardNotifier extends StateNotifier<AddCardState> {
  AddCardNotifier() : super(const AddCardState());

  void setCardNumber(String number) {

    state = state.copyWith(cardNumber: number);
    _check();
  }


  void setCardName(String name) {
    state = state.copyWith(cardName: name);
    _check();
  }

  void setDate(String date) {
    state = state.copyWith(date: date);
    _check();
  }

  void setCvc(String cvc) {
    state = state.copyWith(cvc: cvc);
    _check();
  }

  void changeActive(bool isChange) {
    state = state.copyWith(isActiveCard: isChange);
  }

  _check() {
    if (state.cardNumber.isNotEmpty &&
        state.cardName.isNotEmpty &&
        state.date.isNotEmpty &&
        state.cvc.isNotEmpty) {
      state = state.copyWith(isActiveCard: true);
    } else {
      state = state.copyWith(isActiveCard: false);
    }
  }
}
