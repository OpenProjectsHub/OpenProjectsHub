import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class SearchResultText extends StatelessWidget {
  final String title;
  final VoidCallback canceled;
  final VoidCallback onTap;

  const SearchResultText(
      {super.key,
      required this.title,
      required this.canceled,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    Icon(
                      FlutterRemix.search_2_line,
                      size: 20.r,
                      color: Style.black,
                    ),
                    8.horizontalSpace,
                    Text(
                      title,
                      style: Style.interNormal(
                        size: 14,
                        color: Style.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        height: 20.r,
                        width: double.infinity,
                        color: Style.transparent,
                      ))),
              GestureDetector(
                onTap: canceled,
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
              ),
            ],
          ),
          10.verticalSpace,
          const Divider(
            color: Style.borderColor,
          ),
        ],
      ),
    );
  }
}
