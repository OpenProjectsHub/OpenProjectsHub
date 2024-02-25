import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoppingapp/infrastructure/models/data/addons_data.dart';
import 'package:shoppingapp/infrastructure/models/data/local_cart_model.dart';
import 'package:shoppingapp/infrastructure/models/data/order_active_model.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

import 'package:intl/intl.dart' as intl;
import '../../../../../infrastructure/models/data/cart_data.dart';
import '../../../../../infrastructure/services/local_storage.dart';

class CartOrderItem extends StatelessWidget {
  final CartDetail? cart;
  final Detail? cartTwo;
  final String? symbol;
  final VoidCallback add;
  final VoidCallback remove;
  final bool isActive;
  final bool isOwn;

  const CartOrderItem(
      {super.key,
      required this.add,
      required this.remove,
      required this.cart,
      this.isActive = true,
      this.cartTwo,
      this.isOwn = true,
      this.symbol});

  @override
  Widget build(BuildContext context) {
    num sumPrice = 0;
    num disSumPrice = 0;
    for (Addons e in (isActive ? cart?.addons ?? [] : cartTwo?.addons ?? [])) {
      sumPrice += (e.price ?? 0);
    }
    disSumPrice = (isActive
                ? (cart?.stock?.totalPrice ?? 0)
                : (cartTwo?.stock?.totalPrice ?? 0)) *
            (cart?.quantity ?? 1) +
        sumPrice +
        (isActive ? (cart?.discount ?? 0) : (cartTwo?.discount ?? 0));
    sumPrice += (isActive
            ? (cart?.stock?.totalPrice ?? 0)
            : (cartTwo?.stock?.totalPrice ?? 0)) *
        (isActive ? (cart?.quantity ?? 1) : (cartTwo?.quantity ?? 1));

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        padding: EdgeInsets.all(16.r),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width - 86.w) * 2 / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isActive
                      ? RichText(
                          text: TextSpan(
                              text: cart?.stock?.product?.translation?.title ??
                                  "",
                              style: Style.interNormal(
                                size: 16,
                                color: Style.black,
                              ),
                              children: [
                              if (cart?.stock?.extras?.isNotEmpty ?? false)
                                TextSpan(
                                  text:
                                      " (${cart?.stock?.extras?.first.value ?? ""})",
                                  style: Style.interNormal(
                                    size: 14,
                                    color: Style.textGrey,
                                  ),
                                )
                            ]))
                      : Row(
                          children: [
                            Expanded(
                              child: Text(
                                cartTwo?.stock?.product?.translation?.title ??
                                    "",
                                style: Style.interNormal(
                                  size: 16,
                                  color: Style.black,
                                ),
                              ),
                            ),
                            if (cartTwo?.stock?.extras?.isNotEmpty ?? false)
                              Text(
                                " (${cartTwo?.stock?.extras?.first.value ?? ""})",
                                style: Style.interNormal(
                                  size: 14,
                                  color: Style.textGrey,
                                ),
                              ),
                          ],
                        ),
                  8.verticalSpace,
                  isActive
                      ? Text(
                          (cart?.stock?.product?.translation?.description ??
                              ""),
                          style: Style.interNormal(
                            size: 12,
                            color: Style.textGrey,
                          ),
                          maxLines: 2,
                        )
                      : Text(
                          cartTwo?.stock?.product?.translation?.description ??
                              "",
                          style: Style.interNormal(
                            size: 12.sp,
                            color: Style.textGrey,
                          ),
                          maxLines: 2,
                        ),
                  8.verticalSpace,
                  for (Addons e in (isActive
                      ? cart?.addons ?? []
                      : cartTwo?.addons ?? []))
                    Text(
                      "${e.stocks?.product?.translation?.title ?? ""} ${intl.NumberFormat.currency(
                        symbol: symbol ??
                            LocalStorage.instance.getSelectedCurrency().symbol,
                      ).format((e.price ?? 0) / (e.quantity ?? 1))} x ${(e.quantity ?? 1)}",
                      style: Style.interNormal(
                        size: 13.sp,
                        color: Style.black,
                      ),
                    ),
                  8.verticalSpace,
                  isActive
                      ? Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r)),
                                  border: Border.all(color: Style.textGrey)),
                              child: Row(
                                children: [
                                  ((cart?.bonus ?? false) || !isOwn)
                                      ? const SizedBox.shrink()
                                      : GestureDetector(
                                          onTap: remove,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6.h,
                                                horizontal: 10.w),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Style.black,
                                            ),
                                          ),
                                        ),
                                  Padding(
                                    padding: !((cart?.bonus ?? false) || !isOwn)
                                        ? EdgeInsets.zero
                                        : EdgeInsets.symmetric(
                                            vertical: 6.h, horizontal: 16.w),
                                    child: Text(
                                      LocalStorage.instance
                                          .getCartLocal()
                                          .firstWhere(
                                              (element) =>
                                          element.stockId ==
                                              (cart?.stock?.id),
                                          orElse: () {
                                        return CartLocalModel(
                                            count: 0, stockId: 0);
                                      }).count.toString(),
                                      style: Style.interNoSemi(
                                        size: 14,
                                        color: Style.black,
                                      ),
                                    ),
                                  ),
                                  ((cart?.bonus ?? false) || !isOwn)
                                      ? const SizedBox.shrink()
                                      : GestureDetector(
                                          onTap: add,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6.h,
                                                horizontal: 10.w),
                                            child: const Icon(
                                              Icons.add,
                                              color: Style.black,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            !(cart?.bonus ?? false)
                                ? Column(
                                    children: [
                                      Text(
                                        intl.NumberFormat.currency(
                                          symbol: symbol ?? LocalStorage.instance
                                              .getSelectedCurrency()
                                              .symbol,
                                        ).format((cart?.discount ?? 0) != 0
                                            ? disSumPrice
                                            : sumPrice),
                                        style: Style.interSemi(
                                            size: (cart?.discount ?? 0) != 0
                                                ? 12
                                                : 16,
                                            color: Style.black,
                                            decoration:
                                                (cart?.discount ?? 0) != 0
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none),
                                      ),
                                      (cart?.discount ?? 0) != 0
                                          ? Container(
                                              margin: EdgeInsets.only(top: 8.r),
                                              decoration: BoxDecoration(
                                                  color: Style.redBg,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.r)),
                                              padding: EdgeInsets.all(4.r),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      "assets/svgs/discount.svg"),
                                                  4.horizontalSpace,
                                                  Text(
                                                    intl.NumberFormat.currency(
                                                      symbol: symbol ?? LocalStorage
                                                          .instance
                                                          .getSelectedCurrency()
                                                          .symbol,
                                                    ).format(sumPrice),
                                                    style: Style.interNoSemi(
                                                        size: 14,
                                                        color: Style.red),
                                                  )
                                                ],
                                              ),
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ],
                        )
                      : Row(
                          children: [
                            !(cartTwo?.bonus ?? false)
                                ? Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          intl.NumberFormat.currency(
                                            symbol: symbol?? LocalStorage.instance
                                                .getSelectedCurrency()
                                                .symbol,
                                          ).format(
                                              (cartTwo?.stock?.totalPrice ??
                                                  0)),
                                          style: Style.interSemi(
                                            size: 16,
                                            color: Style.black,
                                          ),
                                        ),
                                        Text(
                                          " X ${cartTwo?.quantity}",
                                          style: Style.interSemi(
                                            size: 16,
                                            color: Style.black,
                                          ),
                                        ),
                                        8.horizontalSpace,
                                        Text(
                                          intl.NumberFormat.currency(
                                            symbol: symbol??  LocalStorage.instance
                                                .getSelectedCurrency()
                                                .symbol,
                                          ).format(sumPrice),
                                          style: Style.interSemi(
                                            size: 16,
                                            color: Style.black,
                                          ),
                                        ),
                                        8.horizontalSpace
                                      ],
                                    ),
                                  )
                                : Text(
                                    intl.NumberFormat.currency(
                                      symbol: symbol ??  LocalStorage.instance
                                          .getSelectedCurrency()
                                          .symbol,
                                    ).format((cartTwo?.originPrice ?? 0)),
                                    style: Style.interSemi(
                                      size: 16,
                                      color: Style.black,
                                    ),
                                  ),
                          ],
                        ),
                ],
              ),
            ),
            4.horizontalSpace,
            Expanded(
              child: Stack(
                children: [
                  CustomNetworkImage(
                      url: isActive
                          ? cart?.stock?.product?.img ?? ""
                          : cartTwo?.stock?.product?.img ?? "",
                      height: 120.h,
                      width: double.infinity,
                      radius: 10.r),
                  (cart?.bonus ?? false) || (cartTwo?.bonus ?? false)
                      ? Positioned(
                          bottom: 4.r,
                          right: 4.r,
                          child: Container(
                            width: 22.w,
                            height: 22.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Style.blueBonus),
                            child: Icon(
                              FlutterRemix.gift_2_fill,
                              size: 16.r,
                              color: Style.white,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
