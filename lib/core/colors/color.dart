import 'package:flutter/material.dart';

class Styles {
  static const Color primary = Color(0xFF6200EA); // Example color, replace with your primary color
  static const Color nearPrimary = Color(0xff113A71); // Example color, replace with your primary color
  static const Color color005B99 = Color(0xff005B99); // Example color, replace with your primary color
  static const Color colorF3F3F3 = Color(0xffF3F3F3); // Example color, replace with your primary color
  static const Color color3D6190 = Color(0xff3D6190); // Example color, replace with your primary color
  static const Color colorF9F9F9 = Color(0xffF9F9F9); // Example color, replace with your primary color
  static const Color colorFF6B6B = Color(0xffFF6B6B); // Example color, replace with your primary color
  static const Color color73FF83 = Color(0xff73FF83); // Example color, replace with your primary color
  static const Color colorEFFFEC = Color(0xffEFFFEC); // Example color, replace with your primary color
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
    thumbColor: WidgetStateProperty.all(accent),
    // isAlwaysShown: false,
    thumbVisibility: WidgetStateProperty.all(true),
    //(người dùng có thể kéo và tương tác với thanh cuộn).
    interactive: true,
  );
  hideKeyBoard() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }
  static Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', ''); // Loại bỏ ký tự '#' nếu có
    return Color(int.parse('FF$hex', radix: 16)); // Thêm 'FF' vào đầu để đảm bảo alpha = 100%
  }
}
