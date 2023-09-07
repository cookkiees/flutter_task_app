import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/app/theme/utils/my_colors.dart';

class MyText {
  static defaultStyle(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      TextOverflow? overflow}) {
    return GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        textStyle: TextStyle(overflow: overflow));
  }

  static headerStyle() {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: MyColors.darkPrimary,
    );
  }

  static titleStyle({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static subtitleStyle(
      {Color? color = Colors.grey, FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
