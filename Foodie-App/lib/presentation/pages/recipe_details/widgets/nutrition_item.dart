import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/infrastructure/models/data/recipe_data.dart';

import '../../../theme/app_style.dart';


class NutritionItem extends StatelessWidget {
  final Nutritions? nutritions;

  const NutritionItem({super.key, this.nutritions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.verticalSpace,
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                '${nutritions?.translation?.title}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: Style.textGrey,
                  letterSpacing: -0.4,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${nutritions?.weight} g',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: Style.textGrey,
                  letterSpacing: -0.4,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${nutritions?.percentage} %',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: Style.textGrey,
                  letterSpacing: -0.4,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        16.verticalSpace,
        Divider(
          thickness: 1.r,
          height: 1.r,
          color: Style.textGrey.withOpacity(0.05),
        ),
      ],
    );
  }
}
