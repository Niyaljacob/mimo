
import 'package:flutter/material.dart';
import 'package:mimo/utils/constance.dart';


class Themes {
  static ThemeData lightModeTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
        color: whiteColor, surfaceTintColor: whiteColor),
    scaffoldBackgroundColor: whiteColor,
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(primary))),
  );

  static ThemeData darkModeTheme = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(color: primary, surfaceTintColor: primary),
      scaffoldBackgroundColor:  primary,
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(primary))));
}
