import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  Style._();
  static const Color bottomNavigationBarColor = Color(0xFF191919);
  static const Color enterOrderButton = Color(0xFFF4F8F7);
  static const Color tabBarBorderColor = Color(0xFFDEDFE1);
  static const Color orderButtonColor = Color(0xFF323232);
  static const Color dotColor = Color(0xFFBDBEC1);
  static const Color switchBg = Color(0xFFD3D3D3);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00FFFFFF);
  static const Color black = Color(0xFF232B2F);
  static const Color blackWithOpacity = Color(0x20232B2F);
  static const Color whiteWithOpacity = Color(0x90FFFFFF);
  static const Color dontHaveAccBtnBack = Color(0xFFF8F8F8);
  static const Color mainBack = Color(0xFFF4F4F4);
  static const Color borderColor = Color(0xFFE6E6E6);
  static const Color brandGreen = Color(0xFF83EA00);
  static const Color textGrey = Color(0xFF898989);
  static const Color recommendBg = Color(0xFFE8C7B0);
  static const Color bannerBg = Color(0xFFF3DED4);
  static const Color bgGrey = Color(0xFFF4F5F8);
  static const Color outlineButtonBorder = Color(0xFFFAFAFA);
  static const Color bottomNavigationBack = Color.fromRGBO(0, 0, 0, 0.06);
  static const Color unselectedBottomItem = Color(0xFFA1A1A1);
  static const Color hintColor = Color(0xFFA7A7A7);
  static const Color unselectedTab = Color(0xFF929292);
  static const Color newStoreDataBorder = Color(0xDCDCDCC9);
  static const Color differBorderColor = Color(0xFFE0E0E0);
  static const Color starColor = Color(0xFFFFA826);
  static const Color dragElement = Color(0xFFC4C5C7);
  static const Color addProductSearchedToBasket = Color.fromRGBO(0, 0, 0, 0.62);
  static const Color rate = Color(0xFFFFB800);
  static const Color red = Color(0xFFFF3D00);
  static const Color redBg = Color(0xFFFFF2EE);
  static const Color blue = Color(0xFF03758E);
  static const Color blueBonus = Color(0xFF0D5FFF);
  static const Color divider = Color.fromRGBO(0, 0, 0, 0.04);
  static const Color reviewText = Color(0xFF88887E);
  static const Color bannerGradient1 = Color.fromRGBO(0, 0, 0, 0.5);
  static const Color bannerGradient2 = Color.fromRGBO(0, 0, 0, 0);
  static const Color brandTitleDivider = Color(0xFF999999);
  static const Color discountProduct = Color(0xFFD21234);
  static const Color notificationTime = Color(0xFF8B8B8B);
  static const Color separatorDot = Color(0xFFD9D9D9);
  static Color shimmerBase = Colors.grey.shade300;
  static Color shimmerHighlight = Colors.grey.shade100;
  static const Color locationAddress = Color(0xFF343434);
  static const Color selectedItemsText = Color(0xFFA0A09C);
  static const Color iconButtonBack = Color(0xFFE9E9E6);
  static const Color shadowCart = Color.fromRGBO(194, 194, 194, 0.65);
  static const Color extrasInCart = Color(0xFF9EA3A8);
  static const Color notDoneOrderStatus = Color(0xFFF5F6F6);
  static const Color unselectedBottomBarBack = Color(0xFFEFEFEF);
  static const Color unselectedBottomBarItem = Color(0xFFB9B9B9);
  static const Color bottomNavigationShadow =
      Color.fromRGBO(207, 207, 207, 0.65);
  static const Color profileModalBack = Color(0xFFF5F5F5);
  static const Color arrowRightProfileButton = Color(0xFFCCCCCC);
  static const Color customMarkerShadow = Color.fromRGBO(117, 117, 117, 0.29);
  static const Color selectedTextFromModal = Color(0xFF202020);
  static const Color verticalDivider = Color(0xFFDDDDDA);
  static const Color unselectedOrderStatus = Color(0xFFE9E9E9);
  static const Color borderRadio = Color(0xFFB8B8B8);
  static const Color shippingType = Color(0xFF95999D);
  static const Color attachmentBorder = Color(0xFFDCDCDC);
  static const Color orderStatusProgressBack = Color(0xFFE7E7E7);

  /// dark theme based colors
  static const Color mainBackDark = Color(0xFF1E272E);
  static const Color dontHaveAnAccBackDark = Color(0xFF2B343B);
  static const Color dragElementDark = Color(0xFFE5E5E5);
  static const Color shimmerBaseDark = Color.fromRGBO(117, 117, 117, 0.29);
  static const Color shimmerHighlightDark = Color.fromRGBO(194, 194, 194, 0.65);
  static const Color borderDark = Color(0xFF494B4D);
  static const Color partnerChatBack = Color(0xFF1A222C);
  static const Color yourChatBack = Color(0xFF25303F);

  /// font style

  static interBold({
    double size = 18,
    Color color = Style.black,
    double letterSpacing = 0
    }) =>
      GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: FontWeight.bold,
          color: color,
          letterSpacing: letterSpacing.sp,
          decoration: TextDecoration.none);

  static interSemi({
    double size = 18,
    Color color = Style.black,
    TextDecoration decoration =  TextDecoration.none,
    double letterSpacing = 0}) =>
      GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: letterSpacing.sp,
          decoration: decoration);

  static interNoSemi({
    double size = 18,
    Color color = Style.black,
    TextDecoration decoration =  TextDecoration.none,
    double letterSpacing = 0}) =>
      GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: letterSpacing.sp,
          decoration: decoration);

  static interNormal(
      {double size = 16,
        Color color = Style.black,
        TextDecoration textDecoration = TextDecoration.none,
        double letterSpacing = 0
      }) =>
      GoogleFonts.inter(
          fontSize: size.sp,
          fontWeight: FontWeight.w500,
          color: color,
          letterSpacing: letterSpacing.sp,
          decoration: textDecoration);

  static interRegular(
      {double size = 16,
        Color color = Style.black,
        TextDecoration textDecoration = TextDecoration.none,
        double letterSpacing = 0}) =>
      GoogleFonts.inter(
          fontSize: size,
          fontWeight: FontWeight.w400,
          color: color,
          letterSpacing: letterSpacing.sp,
          decoration: textDecoration);


}
