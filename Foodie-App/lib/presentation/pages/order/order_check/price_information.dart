import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/application/order/order_state.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shoppingapp/presentation/theme/app_style.dart';
import 'widgets/title_price.dart';

class PriceInformation extends StatelessWidget {
  final bool isOrder;
  final num subTotal;
  final OrderState state;

  const PriceInformation(
      {super.key,
      required this.isOrder,
      required this.subTotal,
      required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        30.verticalSpace,
        TitleAndPrice(
          title: AppHelpers.getTranslation(TrKeys.subtotal),
          rightTitle: intl.NumberFormat.currency(
                  symbol: isOrder
                      ? (state.orderData?.currencyModel?.symbol)
                      : LocalStorage.instance.getSelectedCurrency().symbol,
                  decimalDigits: 2)
              .format(isOrder
                  ? ((state.orderData?.totalPrice ?? 0) -
                      (state.orderData?.deliveryFee ?? 0) -
                      (state.orderData?.tax ?? 0) +
                      (state.orderData?.totalDiscount ?? 0))
                  : ((state.calculateData?.totalPrice ?? 0) -
                      (state.calculateData?.deliveryFee ?? 0) -
                      (state.calculateData?.totalShopTax ?? 0) +
                      (state.calculateData?.totalDiscount ?? 0))),
          textStyle: Style.interRegular(
            size: 16,
            color: Style.black,
          ),
        ),
        16.verticalSpace,
        TitleAndPrice(
          title: AppHelpers.getTranslation(TrKeys.deliveryPrice),
          rightTitle: intl.NumberFormat.currency(
                  symbol: !isOrder
                      ? LocalStorage.instance.getSelectedCurrency().symbol
                      : state.orderData?.currencyModel?.symbol,
                  decimalDigits: 2)
              .format(isOrder
                  ? (state.orderData?.deliveryFee ?? 0)
                  : (state.calculateData?.deliveryFee ?? 0)),
          textStyle: Style.interRegular(
            size: 16,
            color: Style.black,
          ),
        ),
        16.verticalSpace,
        TitleAndPrice(
          title: AppHelpers.getTranslation(TrKeys.tax),
          rightTitle: intl.NumberFormat.currency(
                  symbol: isOrder
                      ? state.orderData?.currencyModel?.symbol
                      : LocalStorage.instance.getSelectedCurrency().symbol,
                  decimalDigits: 2)
              .format(isOrder
                  ? ((state.orderData?.tax ?? 0))
                  : (state.calculateData?.totalShopTax ?? 0)),
          textStyle: Style.interRegular(
            size: 16,
            color: Style.black,
          ),
        ),
        16.verticalSpace,
        TitleAndPrice(
          title: AppHelpers.getTranslation(TrKeys.discount),
          rightTitle:
              "-${intl.NumberFormat.currency(symbol: isOrder ? state.orderData?.currencyModel?.symbol : LocalStorage.instance.getSelectedCurrency().symbol, decimalDigits: 2).format(isOrder ? (state.orderData?.totalDiscount ?? 0) : (state.calculateData?.totalDiscount ?? 0))}",
          textStyle: Style.interRegular(
            size: 16,
            color: Style.red,
          ),
        ),
        16.verticalSpace,
        (isOrder
            ? (state.orderData?.coupon?.price ?? 0)
            : (state.calculateData?.couponPrice ?? 0)) != 0
            ? TitleAndPrice(
                title: AppHelpers.getTranslation(TrKeys.promoCode),
                rightTitle:
                    "-${intl.NumberFormat.currency(symbol: isOrder ? state.orderData?.currencyModel?.symbol : LocalStorage.instance.getSelectedCurrency().symbol, decimalDigits: 2).format(
                  isOrder
                      ? (state.orderData?.coupon?.price ?? 0)
                      : (state.calculateData?.couponPrice ?? 0),
                )}",
                textStyle: Style.interRegular(
                  size: 16,
                  color: Style.red,
                ),
              )
            : const SizedBox.shrink(),
        16.verticalSpace,
        const Divider(
          color: Style.textGrey,
        ),
        16.verticalSpace,
        TitleAndPrice(
          title: AppHelpers.getTranslation(TrKeys.total),
          rightTitle: intl.NumberFormat.currency(
                  symbol: isOrder
                      ? state.orderData?.currencyModel?.symbol
                      : LocalStorage.instance.getSelectedCurrency().symbol,
                  decimalDigits: 2)
              .format(isOrder
                  ? (state.orderData?.totalPrice ?? 0)
                  : (state.calculateData?.totalPrice ?? 0)),
          textStyle: Style.interSemi(
            size: 20,
            color: Style.black,
          ),
        ),
      ],
    );
  }
}
