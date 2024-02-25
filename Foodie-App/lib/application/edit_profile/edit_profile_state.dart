
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
part 'edit_profile_state.freezed.dart';

@freezed
class EditProfileState with _$EditProfileState {

  const factory EditProfileState({
    @Default(false) bool isLoading,
    @Default(false) bool checked,
    @Default(false) bool isSuccess,
    @Default("") String email,
    @Default("") String firstName,
    @Default("") String lastName,
    @Default("") String phone,
    @Default("") String secondPhone,
    @Default("") String birth,
    @Default("") String gender,
    @Default("") String url,
    @Default("") String imagePath,
    @Default(null) ProfileData? userData,
  }) = _EditProfileState;

  const EditProfileState._();
}