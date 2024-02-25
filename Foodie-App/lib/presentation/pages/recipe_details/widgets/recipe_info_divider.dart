import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_style.dart';



class RecipeInfoDivider extends StatelessWidget {
  const RecipeInfoDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.r,
      width: 1.r,
      color: Style.textGrey.withOpacity(0.05),
    );
  }
}
