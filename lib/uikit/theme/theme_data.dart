import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/uikit/uikit.dart';

abstract class AppThemeData {
  static const _lightColorScheme = AppColorScheme.light();
  static const _darkColorScheme = AppColorScheme.dark();

  static final lightThem = ThemeData(
    extensions: const [_lightColorScheme],
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: _lightColorScheme.primary,
    ),
    scaffoldBackgroundColor: _lightColorScheme.background,
    appBarTheme: AppBarTheme(backgroundColor: _lightColorScheme.background),
    textTheme: TextTheme(
        bodyMedium: TextStyle(
            color: _lightColorScheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto')),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _lightColorScheme.background,
        selectedItemColor: _lightColorScheme.primary),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _lightColorScheme.primary,
      contentTextStyle: TextStyle(
        color: _lightColorScheme.primary,
      ),
    ),
  );

  static final darkTheme = ThemeData(
      extensions: const [_darkColorScheme],
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: _darkColorScheme.primary,
        surface: _darkColorScheme.background,
      ),
      scaffoldBackgroundColor: _darkColorScheme.background,
      appBarTheme: AppBarTheme(backgroundColor: _darkColorScheme.background),
      textTheme: TextTheme(
          bodyMedium: TextStyle(
              color: _darkColorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto')),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _darkColorScheme.background,
        selectedItemColor: _darkColorScheme.primary,
      ),
      snackBarTheme: SnackBarThemeData(
          backgroundColor: _darkColorScheme.background,
          contentTextStyle: TextStyle(color: _darkColorScheme.primary)));
}
