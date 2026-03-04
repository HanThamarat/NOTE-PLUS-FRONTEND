import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  // Light theme colors (from GlobalColors)
  static Color get _lightPrimary => HexColor('2196F3');
  static Color get _lightSurface => HexColor('F7F4EF');
  static Color get _lightOnSurface => HexColor('344054');
  static Color get _lightFocus => HexColor('00CE86');

  // Dark theme colors
  static Color get _darkPrimary => HexColor('22C55E'); // accent green
  static Color get _darkSurface => HexColor('050816'); // page background
  static Color get _darkSurfaceContainer => HexColor('111827'); // cards / panels
  static Color get _darkOnSurface => HexColor('E5E7EB');
  static Color get _darkFocus => HexColor('22C55E');

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: _lightPrimary,
        onPrimary: Colors.white,
        surface: _lightSurface,
        onSurface: _lightOnSurface,
        surfaceContainerHighest: HexColor('FFFFFF'),
        error: Colors.red,
        onError: Colors.white,
        outline: Colors.grey.shade400,
      ),
      scaffoldBackgroundColor: _lightSurface,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _lightFocus, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _lightSurface,
        foregroundColor: _lightOnSurface,
        elevation: 0,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: _darkPrimary,
        onPrimary: Colors.black,
        surface: _darkSurface,
        onSurface: _darkOnSurface,
        surfaceContainerHighest: _darkSurfaceContainer,
        error: Colors.redAccent,
        onError: Colors.black,
        outline: Colors.grey.shade700,
      ),
      scaffoldBackgroundColor: _darkSurface,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurfaceContainer,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _darkFocus, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _darkSurface,
        foregroundColor: _darkOnSurface,
        elevation: 0,
      ),
    );
  }
}
