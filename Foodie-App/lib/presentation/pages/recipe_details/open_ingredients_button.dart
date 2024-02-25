import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/pages/recipe_details/widgets/circle_icon_button.dart';

import '../../theme/app_style.dart';



class OpenIngredientsButton extends StatelessWidget {
  final bool isVisible;
  final Function() onTap;

  const OpenIngredientsButton({
    super.key,
    required this.isVisible,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: Style.bgGrey,
      ),
      padding: REdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          CircleIconButton(
            onTap: onTap,
            iconData: isVisible
                ? FlutterRemix.arrow_down_s_line
                : FlutterRemix.arrow_up_s_line,
            width: 42,
            iconColor:  Style.black,
            backgroundColor: Style.white,
          ),
          Expanded(
            child: Center(
              child: Text(
                AppHelpers.getTranslation(TrKeys.ingredients),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color:  Style.black,
                  letterSpacing: -0.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
