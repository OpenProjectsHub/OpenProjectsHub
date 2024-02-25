import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';


class CircleIconButton extends StatelessWidget {
  final int? width;
  final IconData iconData;
  final Function() onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final int elevation;
  final int? badgeCount;
  final bool? isLoading;

  const CircleIconButton({
    super.key,
    this.width,
    required this.onTap,
    required this.iconData,
    this.backgroundColor,
    this.iconColor,
    this.elevation = 0,
    this.badgeCount,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Style.bgGrey,
      borderRadius: BorderRadius.circular(((width ?? 40) / 2).r),
      elevation: elevation.r,
      child: InkWell(
        borderRadius: BorderRadius.circular(((width ?? 40) / 2).r),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(((width ?? 40) / 2).r),
          ),
          alignment: Alignment.center,
          width: (width ?? 40).r,
          height: (width ?? 40).r,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              (isLoading ?? false)
                  ? Center(
                      child: SizedBox(
                        width: ((width ?? 40) / 3).r,
                        height: ((width ?? 40) / 3).r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.r,
                          color: Style.brandGreen,
                        ),
                      ),
                    )
                  : badgeCount != null
                      ? Container(
                          width: (width ?? 40).r,
                          height: (width ?? 40).r,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Style.brandGreen,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$badgeCount',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: Style.white,
                              letterSpacing: -0.4,
                            ),
                          ),
                        )
                      : Icon(
                          iconData,
                          size: ((width ?? 40) / 2).r,
                          color:
                              iconColor ?? Style.textGrey,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
