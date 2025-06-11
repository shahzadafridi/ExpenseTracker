import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = const Color(0xff3F8782);
  static Color darkGrey = const Color(0xff525252);
  static Color grey = const Color(0xff737477);
  static Color lightGrey = const Color(0xffAAAAAA);

  static Color darkPrimary = const Color(0xff3F8782);
  static Color lightPrimary = const Color(0xff69AEA9); // color with 80% opacity
  static Color grey1 = const Color(0xff707070);
  static Color grey2 = const Color(0xff797979);
  static Color white = const Color(0xffFFFFFF);
  static Color error = const Color(0xffe61f34);

  static Color black = const Color(0xff000000);
  static Color green = const Color(0xff25A969);
  static Color red = const Color(0xffF96251);

  static const Color gradientStart = Color(0xFF69AEA9);
  static const Color gradientEnd = Color(0xFF3F8782);
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color lineChartGradientStart = Color(0x4D438883);
  static const Color lineChartGradientend = Color(0x3F8782);
  static const LinearGradient lineChartGradient = LinearGradient(
    colors: [lineChartGradientStart, lineChartGradientend],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}