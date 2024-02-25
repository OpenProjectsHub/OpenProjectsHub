
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class AppBarBottomSheet extends StatelessWidget {
  final String title;
  const AppBarBottomSheet({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: const EdgeInsets.only(
              top: 16, right: 32, bottom: 16, left: 0),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Style.black,
          ),
        ),
        Text(
          title,
          style: Style.interNoSemi(
            size: 20,
            color: Style.black,
            letterSpacing: -0.01
          ),
        ),
        Container(
          width: 24.w,
          height: 24.h,
          margin: const EdgeInsets.all(8),
        ),
      ],
    );
  }
}
