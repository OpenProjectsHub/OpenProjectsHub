import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/loading.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';


class CommonMaterialButton extends StatelessWidget {
  final int? height;
  final Color? color;
  final String? text;
  final int? horizontalPadding;
  final bool isLoading;
  final Function()? onTap;
  final int? fontSize;
  final int? borderRadius;
  final Color? fontColor;
  final FontWeight? fontWeight;

  const CommonMaterialButton({
    super.key,
    this.height,
    this.color,
    this.text,
    this.horizontalPadding,
    this.isLoading = false,
    this.onTap,
    this.fontSize,
    this.borderRadius,
    this.fontColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular((borderRadius ?? 45).r),
      color: color ?? Style.textGrey,
      child: InkWell(
        borderRadius: BorderRadius.circular((borderRadius ?? 45).r),
        onTap: onTap,
        child: Container(
          height: (height ?? 40).r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular((borderRadius ?? 45).r),
          ),
          padding: REdgeInsets.symmetric(
            horizontal: (horizontalPadding ?? 44).toDouble(),
          ),
          child: isLoading
              ? const Loading()
              : Text(
                  text ?? AppHelpers.getTranslation(TrKeys.apply),
                  style: GoogleFonts.inter(
                    color: fontColor ?? Style.bgGrey,
                    fontSize: (fontSize ?? 14).sp,
                    letterSpacing: -0.4,
                    fontWeight: fontWeight ?? FontWeight.w400,
                  ),
                ),
        ),
      ),
    );
  }
}
