import 'package:flutter/material.dart';

class AppThemeConfig {
  final ColorScheme _colorScheme;
  final Color _scaffoldBackgroundColor;
  final Color _primaryTextColor;
  final Color _secondaryTextColor;

  AppThemeConfig.Light()
      : _colorScheme = const ColorScheme.light(
    brightness: Brightness.light,
    primary: Color(0xFF217CF3),
    onPrimary: Colors.white,
    onBackground: Colors.white,
    secondary: Color(0xFF262A35),
    onSecondary: Colors.white,
    background: Color(0xFFB3B6BE),
  ),
        _scaffoldBackgroundColor = Colors.white,
        _primaryTextColor = const Color(0xFF262A35),
        _secondaryTextColor = const Color(0xFFB3B6BE);

  AppThemeConfig.Dark()
      : _colorScheme = const ColorScheme.light(
      primary: Color(0xFF2122F3),
      onPrimary: Colors.white,
      secondary: Color(0xFF260035),
      onBackground: Colors.white,
      onSecondary: Colors.white),
        _scaffoldBackgroundColor = Colors.black,
        _primaryTextColor = const Color(0xFF262A35),
        _secondaryTextColor = const Color(0xFFB3B6BE);

  ThemeData GetAppTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black),
      scaffoldBackgroundColor: _scaffoldBackgroundColor,
      colorScheme: _colorScheme,
      textTheme: _GetFaTextTheme(),
      hintColor: _secondaryTextColor,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(fontSize: 14),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _primaryTextColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  TextTheme _GetFaTextTheme() {
    return TextTheme(
      button: TextStyle(
        fontFamily: 'IranSans',
        color: _secondaryTextColor,
      ),
      subtitle1: TextStyle(
        fontFamily: 'IranSans',
        color: _secondaryTextColor,
      ),
      bodyText1: TextStyle(
        fontFamily: 'IranSans',
        color: _primaryTextColor,
      ),
      bodyText2: TextStyle(
        fontFamily: 'IranSans',
        color: _primaryTextColor,
      ),
      headline6: const TextStyle(
        fontFamily: 'IranSans',
        fontWeight: FontWeight.bold,
      ),
      caption: TextStyle(
        fontFamily: 'IranSans',
        color: _secondaryTextColor,
      ),
    );
  }
}
