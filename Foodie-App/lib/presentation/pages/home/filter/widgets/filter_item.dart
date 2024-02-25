import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/models/data/take_data.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';
import 'package:intl/intl.dart' as intl;

// ignore: must_be_immutable
class FilterItem extends StatelessWidget {
  final String title;
  final List list;
  final bool isRating;
  final bool isPrice;
  final bool isOffer;
  final bool isSort;
  final dynamic currentItem;
  final String? currentItemTwo;
  ValueChanged onTap;

  FilterItem({
    super.key,
    required this.title,
    required this.list,
    this.isRating = false,
    this.isOffer = false,
    this.isSort = false,
    this.currentItem,
    this.currentItemTwo = "",
    required this.onTap,
    this.isPrice = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.only(left: 18.w, right: 18.w, top: 18.h, bottom: 10.h),
      decoration: BoxDecoration(
          color: Style.white.withOpacity(0.9),
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Style.interNoSemi(
              size: 16.sp,
              color: Style.black,
            ),
          ),
          18.verticalSpace,
          Wrap(
            children: list.map((e) => GestureDetector(
                onTap: () => onTap(e),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: ((e.runtimeType == TakeModel)
                              // ignore: unrelated_type_equality_checks
                              ? (currentItem == (e as TakeModel).id || currentItemTwo == e.id)
                              : (currentItem == e || currentItemTwo == e))
                          ? Style.brandGreen
                          : Style.bgGrey),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isRating
                          ? Row(
                              children: [
                                Icon(
                                  FlutterRemix.star_smile_fill,
                                  size: 16.r,
                                ),
                                6.horizontalSpace,
                              ],
                            )
                          : isOffer
                              ? Row(
                                  children: [
                                    Icon(
                                      FlutterRemix.leaf_fill,
                                      size: 16.r,
                                    ),
                                    6.horizontalSpace,
                                  ],
                                )
                              : isSort
                                  ? Row(
                                      children: [
                                        Container(
                                          width: 14.w,
                                          height: 14.h,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: currentItem == e
                                                      ? 4.r
                                                      : 2.r,
                                                  color: Style.black),
                                              color: Style.transparent,
                                              shape: BoxShape.circle),
                                        ),
                                        6.horizontalSpace,
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                      isPrice
                          ? Text(
                              intl.NumberFormat.currency(
                                symbol: LocalStorage.instance
                                    .getSelectedCurrency()
                                    .symbol,
                              ).format(double.tryParse(e)),
                              style: Style.interNormal(
                                size: 14,
                                color: Style.black,
                              ),
                            )
                          : isOffer
                              ? Text(
                                  (e as TakeModel).translation?.title ?? "",
                                  style: Style.interNormal(
                                    size: 14,
                                    color: Style.black,
                                  ),
                                )
                              : Text(
                                  e,
                                  style: Style.interNormal(
                                    size: 14,
                                    color: Style.black,
                                  ),
                                ),
                    ],
                  ),
                ),
              )).toList(),
          )
        ],
      ),
    );
  }
}
