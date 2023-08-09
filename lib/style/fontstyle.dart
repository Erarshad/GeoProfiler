import 'package:flutter/material.dart';
import 'package:geoprofiler/const/const.dart';
import 'package:responsive_framework/responsive_framework.dart';

normalFont(BuildContext context) {
  return TextStyle(
      color: Colors.white,
      fontSize: ResponsiveValue<double>(context, conditionalValues: [
        Condition.equals(name: MOBILE, value: 11),
        Condition.between(start: 800, end: 1100, value: 12),
        Condition.between(start: 1000, end: 1200, value: 14),
      ]).value,
      fontFamily: fontFamily,
      height: 1.0);
}

writingFontStyle(double fontSize,Color color){

      return   TextStyle(
        fontFamily: fontFamily,
        height: 1.0,
        fontSize: fontSize,
        color: color,
    );

}



TextStyle captionWhite = const TextStyle(
    fontFamily: fontFamily,
    height: 1.0,
    fontSize: 14.0,
    color: Colors.white,
);

TextStyle alert = const TextStyle(
    fontFamily: fontFamily,
    height: 1.0,
    fontSize: 13.0,
    color: Colors.black,
    fontWeight: FontWeight.w500
);

TextStyle alertText = const TextStyle(
    fontFamily: fontFamily,
    height: 1.0,
    fontSize: 13.0,
    color: Colors.black,

);


TextStyle hintFontStyle = const TextStyle(
    fontFamily: fontFamily,
    height: 1.0,
    fontSize: 17.0,
    color: Colors.white,
);

