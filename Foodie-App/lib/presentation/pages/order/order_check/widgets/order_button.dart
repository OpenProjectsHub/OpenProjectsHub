import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/application/payment_methods/payment_provider.dart';
import 'package:shoppingapp/application/shop_order/shop_order_provider.dart';
import 'package:shoppingapp/infrastructure/services/app_constants.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/pages/order/order_check/widgets/refund_screen.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

import '../../../../../application/order/order_provider.dart';
import '../../../../../infrastructure/services/local_storage.dart';

import 'package:intl/intl.dart' as intl;


class OrderButton extends StatelessWidget {
  final bool isOrder;
  final bool isLoading;
  final bool isRepeatLoading;
  final OrderStatus orderStatus;
  final VoidCallback createOrder;
  final VoidCallback cancelOrder;
  final VoidCallback repeatOrder;
  final VoidCallback callShop;
  final VoidCallback callDriver;
  final VoidCallback sendSmsDriver;
  final bool isRefund;

  const OrderButton(
      {super.key,
      required this.isOrder,
      required this.orderStatus,
      required this.createOrder,
      required this.isLoading,
      required this.cancelOrder,
      required this.callShop,
      required this.callDriver,
      required this.sendSmsDriver,
      required this.isRefund,
      required this.repeatOrder,
      required this.isRepeatLoading});

  @override
  Widget build(BuildContext context) {
    if (isOrder) {
      switch (orderStatus) {
        case OrderStatus.onWay:
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 60) / 2,
                child: CustomButton(
                  isLoading: isLoading,
                  background: Style.black,
                  textColor: Style.white,
                  title: AppHelpers.getTranslation(TrKeys.callTheDriver),
                  onPressed: callDriver,
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 60) / 2,
                child: CustomButton(
                  isLoading: isLoading,
                  background: Style.black,
                  textColor: Style.white,
                  title: AppHelpers.getTranslation(TrKeys.sendMessage),
                  onPressed: sendSmsDriver,
                ),
              ),
            ],
          );
        case OrderStatus.open:
          return CustomButton(
            isLoading: isLoading,
            background: Style.red,
            textColor: Style.white,
            title: AppHelpers.getTranslation(TrKeys.cancelOrder),
            onPressed: cancelOrder,
          );
        case OrderStatus.accepted:
          return CustomButton(
            isLoading: isLoading,
            background: Style.black,
            textColor: Style.white,
            title: AppHelpers.getTranslation(TrKeys.callCenterRestaurant),
            onPressed: callShop,
          );
        case OrderStatus.ready:
          return CustomButton(
            isLoading: isLoading,
            background: Style.black,
            textColor: Style.white,
            title: AppHelpers.getTranslation(TrKeys.callCenterRestaurant),
            onPressed: callShop,
          );
        case OrderStatus.delivered:
          return isRefund
              ? Column(
                  children: [
                    CustomButton(
                      isLoading: isRepeatLoading,
                      background: Style.transparent,
                      borderColor: Style.black,
                      textColor: Style.black,
                      title: AppHelpers.getTranslation(TrKeys.repeatOrder),
                      onPressed: repeatOrder,
                    ),
                    10.verticalSpace,
                    CustomButton(
                      isLoading: isLoading,
                      title: AppHelpers.getTranslation(TrKeys.reFound),
                      background: Style.red,
                      textColor: Style.white,
                      onPressed: () {
                        AppHelpers.showCustomModalBottomSheet(
                            context: context,
                            modal: const RefundScreen(),
                            isDarkMode: false);
                      },
                    ),
                  ],
                )
              : const SizedBox.shrink();
        case OrderStatus.canceled:
          return const SizedBox.shrink();
      }
    } else {
      return Consumer(builder: (context, ref, child) {
        final bool isNotEmptyCart = (ref
                .watch(shopOrderProvider)
                .cart
                ?.userCarts
                ?.first
                .cartDetails
                ?.isNotEmpty ??
            false);
        final bool isNotEmptyPaymentType = ((AppHelpers.getPaymentType() ==
                "admin")
            ? (ref.watch(paymentProvider).payments.isNotEmpty)
            : (ref.watch(orderProvider).shopData?.shopPayments?.isNotEmpty ??
                false));

        return CustomButton(
          isLoading: isLoading,
          background: isNotEmptyCart || isNotEmptyPaymentType
              ? (ref.watch(orderProvider).tabIndex == 0 ||
                      (ref.watch(orderProvider).selectDate != null)
                  ? Style.brandGreen
                  : Style.bgGrey)
              : Style.brandGreen,
          textColor: isNotEmptyCart || isNotEmptyPaymentType
              ? (ref.watch(orderProvider).tabIndex == 0 ||
                      (ref.watch(orderProvider).selectDate != null)
                  ? Style.black
                  : Style.textGrey)
              : Style.black,
          title:
              "${AppHelpers.getTranslation(TrKeys.continueToPayment)} — ${intl.NumberFormat.currency(symbol: LocalStorage.instance.getSelectedCurrency().symbol, decimalDigits: 2).format(ref.watch(orderProvider).calculateData?.totalPrice ?? 0)}",
          onPressed: createOrder,
        );
      });
    }
  }
}
