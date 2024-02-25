import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

import 'animation_button_effect.dart';

class PopButton extends StatelessWidget {
  const PopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: AnimationButtonEffect(
        child: Container(
          decoration: BoxDecoration(
              color: Style.black,
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          padding: EdgeInsets.all(14.h),
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: Style.white,
          ),
        ),
      ),
    );
  }
}
