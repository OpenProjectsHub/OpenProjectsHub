import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {

  const factory MainState({
    @Default([]) List<Widget> listOfWidget,
    @Default(0) int selectIndex,
    @Default(false) bool isScrolling,
  }) = _MainState;

  const MainState._();
}