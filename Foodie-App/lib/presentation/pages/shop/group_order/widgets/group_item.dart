import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';
import 'package:intl/intl.dart' as intl;

class GroupItem extends StatelessWidget {
  final String name;
  final bool isChoosing;
  final num? price;
  final bool isDeleteButton;
  final VoidCallback onDelete;

  const GroupItem(
      {super.key,
      required this.name,
      required this.price,
      required this.isChoosing,
      required this.onDelete,
      this.isDeleteButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.h),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: const BoxDecoration(
                        color: Style.bgGrey, shape: BoxShape.circle),
                    padding: EdgeInsets.all(6.r),
                    child: SvgPicture.asset("assets/svgs/avatar.svg")),
                10.horizontalSpace,
                Expanded(
                  child: Text(
                    name,
                    style: Style.interNormal(
                      size: 14,
                      color: Style.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "${isChoosing ? AppHelpers.getTranslation(TrKeys.choosing) : AppHelpers.getTranslation(TrKeys.done)} — ",
                style: Style.interNormal(
                  size: 14,
                  color: Style.black,
                ),
              ),
              Text(
                intl.NumberFormat.currency(
                  symbol: LocalStorage.instance.getSelectedCurrency().symbol,
                ).format(price),
                style: Style.interSemi(
                  size: 14,
                  color: Style.black,
                ),
              ),
              isDeleteButton ?  GestureDetector(
                onTap: onDelete,
                child: Container(
                  color: Style.transparent,
                  child: Padding(
                    padding: EdgeInsets.all(4.r),
                    child: Icon(
                      FlutterRemix.close_fill,
                      size: 20.r,
                      color: Style.black,
                    ),
                  ),
                ),
              ) : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
