
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'time_state.dart';




class TimeNotifier extends StateNotifier<TimeState> {
  TimeNotifier() : super(const TimeState());

  void reset(){
    state = state.copyWith(currentIndexOne: 0,currentIndexTwo: 0,selectIndex: null);
  }

  void changeOne(int index) {
    state = state.copyWith(currentIndexOne: index);
  }

  void selectIndex(int index) {
    state = state.copyWith(selectIndex: index);
  }

  void changeTwo(int index) {
    state = state.copyWith(currentIndexTwo: index);
  }

}
