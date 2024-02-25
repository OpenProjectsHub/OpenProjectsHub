import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class OrderContainer extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const OrderContainer(
      {super.key,
      required this.icon,
      required this.title,
      required this.description,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Style.bgGrey,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Row(
          children: [
            icon,
            14.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Style.interNormal(
                    size: 12,
                    color: Style.textGrey,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width-164.w,
                  child: Text(
                    description,
                    style: Style.interBold(
                      size: 14,
                      color: Style.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }
}
