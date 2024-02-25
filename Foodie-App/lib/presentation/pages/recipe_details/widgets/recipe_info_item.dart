import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_style.dart';


class RecipeInfoItem extends StatelessWidget {
  final String title;
  final String value;

  const RecipeInfoItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: Style.black,
            letterSpacing: -0.4,
          ),
        ),
        4.verticalSpace,
        Text(
          value,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            color: Style.black,
            letterSpacing: -0.4,
          ),
        ),
      ],
    );
  }
}
