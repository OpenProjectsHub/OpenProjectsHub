
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';

import 'main_state.dart';

class MainNotifier extends StateNotifier<MainState> {
  MainNotifier() : super(const MainState());

  void selectIndex(int index) {
    state = state.copyWith(selectIndex: index);
  }


  bool checkGuest(){
    return LocalStorage.instance.getToken().isEmpty;
  }

  void changeScrolling(bool isScrolling){
    state = state.copyWith(isScrolling: isScrolling);
  }
}
