import 'package:flutter/material.dart';

class Styles {
  static const Color primary = Color(0xFF6200EA); // Example color, replace with your primary color
  static const Color nearPrimary = Color(0xff113A71); // Example color, replace with your primary color
  static const Color secondary = Color(0xFF03DAC6); // Example color, replace with your secondary color
  static const Color accent = Color(0xFFEAB135); // Example color, replace with your accent color
  static const Color dark = Color(0xFF121212); // Dark color for dark theme or text
  static const Color grey = Color(0xFF7F8489); // Dark color for dark theme or text
  static const Color greyLight = Color(0xFFE5E5E5); // Dark color for dark theme or text
  static const Color light = Color(0xFFFFFFFF); // Light color for light theme or background
  static const Color blue = Color(0xFF00B2F6); // Example blue color, replace with your desired color
  static const Color nearBlue = Color(0xffECF5FF); // Example blue color, replace with your desired color
  static const Color blueIcon = Color(0xFF0393CD); // Example blue color, replace with your desired color
  static const Color blueLight = Color(0xFFD0F0FD); // Example blue color, replace with your desired color
  static const Color error = Color(0xFFB00020); // Error color, used for validation or error messages

  static double defaultPadding = 20.0;

  static BorderRadius defaultBorderRadius = BorderRadius.circular(20);

  static ScrollbarThemeData scrollbarTheme =
  const ScrollbarThemeData().copyWith(
    thumbColor: MaterialStateProperty.all(accent),
    // isAlwaysShown: false,
    thumbVisibility: MaterialStateProperty.all(true),
    //(người dùng có thể kéo và tương tác với thanh cuộn).
    interactive: true,
  );
  hideKeyBoard() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }
// Add more color definitions as per your design requirements
}
