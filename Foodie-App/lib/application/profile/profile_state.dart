import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shoppingapp/infrastructure/models/data/referral_data.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(true) bool isLoading,
    @Default(true) bool isReferralLoading,
    @Default(false) bool isSaveLoading,
    @Default(true) bool isLoadingHistory,
    @Default(0) int typeIndex,
    @Default("") String bgImage,
    @Default("") String logoImage,
    @Default(null) AddressData? addressModel,
    @Default(null) ProfileData? userData,
    @Default(null) ReferralModel? referralData,
    @Default([]) List<WalletData>? walletHistory,
  }) = _ProfileState;

  const ProfileState._();
}
