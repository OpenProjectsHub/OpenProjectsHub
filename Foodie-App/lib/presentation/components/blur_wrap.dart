import 'dart:ui';

import 'package:flutter/material.dart';

class BlurWrap extends StatelessWidget {
  final Widget child;
  final BorderRadius radius;
  final double blur;

  const BlurWrap(
      {super.key, required this.child, required this.radius, this.blur = 13});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: child,
      ),
    );
  }
}
