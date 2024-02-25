import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../infrastructure/models/data/recipe_data.dart';
import '../../../components/small_dot.dart';
import '../../../theme/app_style.dart';


class IngredientItem extends StatelessWidget {
  final RecipeProduct? product;

  const IngredientItem({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SmallDot(
            color: Style.textGrey.withOpacity(0.5),
          ),
          4.horizontalSpace,
          Expanded(
            child: Text(
              '${product?.product?.translation?.title}',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: Style.textGrey,
                letterSpacing: -0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
