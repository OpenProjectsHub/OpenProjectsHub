
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';

import '../../../infrastructure/models/models.dart';

class ShopItemInMap extends StatelessWidget {
  final ShopData shop;
  final VoidCallback onTap;

  const ShopItemInMap({
    super.key,
    required this.shop,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 214.r,
        width: 162.r,
        margin: EdgeInsetsDirectional.only(end: 14.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Style.bgGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 114.r,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.r),
                      topLeft: Radius.circular(15.r),
                    ),
                    child: SizedBox(
                      width: 162.r,
                      height: 95.r,
                      child: Stack(
                        children: [
                          CustomNetworkImage(
                            url: shop.backgroundImg ?? "",
                            width: double.infinity,
                            height: double.infinity,
                            radius: 0,
                          ),
                          Container(
                            width: double.infinity,
                            height: 95.r,
                            decoration: BoxDecoration(
                              color: Style.black.withOpacity(0.35),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    bottom: 0,
                    child: CustomNetworkImage(
                      url: shop.logoImg ?? "",
                      height: 38,
                      width: 38,
                      radius: 19,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${shop.translation?.title}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: Style.black,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        FlutterRemix.star_smile_fill,
                        size: 14.r,
                        color: Style.rate,
                      ),
                      6.horizontalSpace,
                      Text(
                        '${shop.avgRate ?? 0.0}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                          color: Style.black,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: REdgeInsets.only(left: 16, right: 16, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    FlutterRemix.map_pin_fill,
                    size: 12.r,
                    color: Style.textGrey,
                  ),
                  6.horizontalSpace,
                  Expanded(
                    child: Text(
                      '${shop.translation?.address}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: Style.textGrey,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
