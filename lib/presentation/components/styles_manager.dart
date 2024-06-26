import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
    // overflow: TextOverflow.ellipsis,
  );
}

TextStyle getSmallLightStyle({
  double fontSize = FontSize.s15,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

TextStyle getSmallRegularStyle({
  double fontSize = FontSize.s15,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

TextStyle getMeduimStyle({
  double fontSize = FontSize.s20,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

TextStyle getRegularStyle({
  double fontSize = FontSize.s26,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

TextStyle getLargeStyle({
  double fontSize = FontSize.s35,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}
