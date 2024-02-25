import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import '../../theme/theme.dart';

class SearchTextField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final Color bgColor;
  final bool isBorder;
  final bool isRead;
  final bool autofocus;

  const SearchTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.textEditingController,
    this.onChanged,
    this.bgColor = Style.transparent,
    this.isBorder = false,
    this.isRead = false,
    this.autofocus = false,
     this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isRead,
      autofocus: autofocus,
      onTap: onTap,
      style: Style.interRegular(
        size: 16,
        color: Style.black,
      ),
      onChanged: onChanged,
      controller: textEditingController,
      cursorColor: Style.black,
      cursorWidth: 1,
      decoration: InputDecoration(
        hintStyle: Style.interNormal(
          size: 13,
          color: Style.hintColor,
        ),
        hintText: hintText ?? AppHelpers.getTranslation(TrKeys.searchProducts),
        contentPadding: REdgeInsets.symmetric(horizontal: 15, vertical: 14),
        prefixIcon: Icon(
          FlutterRemix.search_2_line,
          size: 20.r,
          color: Style.black,
        ),
        suffixIcon: suffixIcon,
        fillColor: bgColor,
        filled: true,
        focusedBorder: isBorder ? const OutlineInputBorder() : InputBorder.none,
        border: isBorder ? const OutlineInputBorder() : InputBorder.none,
        enabledBorder: isBorder ? const OutlineInputBorder() : InputBorder.none,
      ),
    );
  }
}
