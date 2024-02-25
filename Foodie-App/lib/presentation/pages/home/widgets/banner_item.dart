import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';
import 'package:shoppingapp/presentation/pages/home/widgets/banner_screen.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class BannerItem extends StatelessWidget {
  final BannerData banner;

  const BannerItem({
    super.key,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppHelpers.showCustomModalBottomSheet(
            context: context,
            modal: BannerScreen(
              bannerId: banner.id ?? 0,
              image: banner.img ?? "",
              desc: banner.translation?.description ?? "",
            ),
            isDarkMode: false);
      },
      child: Container(
          margin: EdgeInsets.only(right: 6.r),
          width: MediaQuery.of(context).size.width - 46,
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
          ),
          child: Stack(
            children: [
              CustomNetworkImage(
                bgColor: Style.white,
                url: banner.img ?? "",
                height: double.infinity,
                width: double.infinity,
                radius: 8.r,
              ),
              Positioned(
                top: 16.r,
                left: 16.r,
                bottom: 16.r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.r, vertical: 4.r),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Style.white.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 40,
                                  offset: const Offset(
                                      0, -2), // changes position of shadow
                                ),
                              ],
                              color: Style.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(100.r)),
                          child: Text(
                            banner.translation?.buttonText ?? "",
                            style:
                                Style.interNoSemi(size: 14, color: Style.white),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      banner.translation?.title ?? "",
                      style: Style.interNoSemi(size: 18, color: Style.black),
                      maxLines: 2,
                    ),
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        banner.translation?.description ?? "",
                        style: Style.interRegular(size: 12, color: Style.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
