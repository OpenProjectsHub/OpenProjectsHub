import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/infrastructure/models/data/recipe_data.dart';

import '../../../theme/app_style.dart';


class InstructionItem extends StatelessWidget {
  final int index;
  final Instructions? instructions;

  const InstructionItem({super.key, required this.index, this.instructions});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${index + 1}.',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            color: Style.textGrey,
            letterSpacing: -0.4,
          ),
        ),
        14.horizontalSpace,
        Expanded(
          child: Text(
            '${instructions?.translation?.title}',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: Style.textGrey,
              letterSpacing: -0.4,
            ),
          ),
        ),
      ],
    );
  }
}
