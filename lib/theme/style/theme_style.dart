import 'package:flutter/material.dart';

import '../color/colors.dart';
import '../fonts/font.dart';




class AppTextStyle {
  AppTextStyle._();

  static TextStyle righteous({
    Color? textColor,
    double? textSize,
  }) {
    return TextStyle(
      fontSize: textSize ?? 14.0,
      fontFamily: Fonts.righteous,
      color: textColor ?? AppColors.textPrimary,
    );
  }

  static TextStyle poppins({
    Color? textColor,
    double? textSize,
  }) {
    return TextStyle(
      fontSize: textSize ?? 14.0,
      fontFamily: Fonts.poppins,
      color: textColor ?? AppColors.textPrimary,
      height: 1.27, letterSpacing: -0.1,
    );
  }
  static TextStyle poppinsMedium({
    Color? textColor,
    double? textSize,
  }) {
    return TextStyle(
      fontSize: textSize ?? 14.0,
      fontFamily: Fonts.poppins_Medium,
      color: textColor ?? AppColors.textPrimary,
      height: 1.27, letterSpacing: 0.5,
    );
  }

  static TextStyle poppinsSemiBold({
    Color? textColor,
    double? textSize,
  }) {
    return TextStyle(
      fontSize: textSize ?? 14.0,
      fontFamily: Fonts.poppins_SemiBold,
      color: textColor ?? AppColors.textPrimary,

    );
  }
  static TextStyle poppinsBold({
    Color? textColor,
    double? textSize,
  }) {
    return TextStyle(
      fontSize: textSize ?? 14.0,
      fontFamily: Fonts.poppins_Bold,
      color: textColor ?? AppColors.textPrimary,

    );
  }
}

