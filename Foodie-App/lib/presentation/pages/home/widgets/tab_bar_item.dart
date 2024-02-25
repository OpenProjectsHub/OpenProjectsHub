import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class CategoryBarItem extends StatelessWidget {
  final String image;
  final String title;
  final int index;
  final VoidCallback onTap;
  final bool isActive;

  const CategoryBarItem(
      {super.key,
      required this.image,
      required this.title,
      required this.index,
      this.isActive = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: index == 1 ? 4.r : 0, right: 8.r),
        width: 84.w,
        height: 84.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            color: isActive ? Style.brandGreen : Style.white),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomNetworkImage(
                url: image,
                height: 48.r,
                width: 48.r,
                radius: 0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  title,
                  style: Style.interNormal(
                    size: 12,
                    color: Style.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
