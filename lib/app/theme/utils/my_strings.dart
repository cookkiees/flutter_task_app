import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/app/theme/utils/my_colors.dart';

class MyText {
  static defaultStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static headerStyle() {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: MyColors.darkPrimary,
    );
  }

  static titleStyle() {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: MyColors.darkPrimary,
    );
  }

  static subtitleStyle({Color? color = Colors.grey}) {
    return GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }
}
