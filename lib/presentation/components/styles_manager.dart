import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    overflow: TextOverflow.ellipsis,
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
  double fontSize = FontSize.s18,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

TextStyle getRegularStyle({
  double fontSize = FontSize.s26,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}
