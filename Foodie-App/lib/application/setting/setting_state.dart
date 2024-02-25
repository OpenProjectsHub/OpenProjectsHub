
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoppingapp/infrastructure/models/data/notification_list_data.dart';


part 'setting_state.freezed.dart';

@freezed
class SettingState with _$SettingState {

  const factory SettingState({
    @Default(true) bool isLoading,
    @Default(null) List<NotificationData>? notifications
  }) = _SettingState;

  const SettingState._();
}