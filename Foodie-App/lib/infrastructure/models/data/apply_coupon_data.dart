class ApplyCouponData {
  final int shopId;
  final String? coupon;
  final bool? isApplied;
  final bool? isError;

  ApplyCouponData({
    required this.shopId,
    this.coupon,
    this.isApplied,
    this.isError,
  });

  ApplyCouponData copyWith({
    String? coupon,
    bool? isApplied,
    bool? isError,
  }) =>
      ApplyCouponData(
        shopId: shopId,
        coupon: coupon ?? this.coupon,
        isApplied: isApplied ?? this.isApplied,
        isError: isError ?? this.isError,
      );
}
