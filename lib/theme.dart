// lib/theme.dart
import 'package:flutter/material.dart';

/// エメラルドグリーンを基調としたカスタムカラーパレット
const MaterialColor customSwatch = MaterialColor(0xFF50C878, <int, Color>{
  // エメラルドグリーンを500番のベースカラーに
  50: Color(0xFFE6F7ED), // 明るいエメラルドグリーン
  100: Color(0xFFC1EDD2),
  200: Color(0xFF9AE0B7),
  300: Color(0xFF75D39D),
  400: Color(0xFF58C888),
  500: Color(0xFF50C878), // メインのエメラルドグリーン
  600: Color(0xFF45B86A),
  700: Color(0xFF3A9E5B),
  800: Color(0xFF308A4F),
  900: Color(0xFF21683E), // 濃いエメラルドグリーン
});

/// アプリ共通の色・文字スタイルをまとめたテーマ
final ThemeData appTheme = ThemeData(
  primarySwatch: customSwatch,
  scaffoldBackgroundColor: Colors.white, // 背景色は引き続き白で明るさを維持
  appBarTheme: AppBarTheme(
    backgroundColor: customSwatch[600], // AppBarは少し濃い目のエメラルドグリーン
    foregroundColor: Colors.white,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: customSwatch[500], // FABはメインのエメラルドグリーン
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: customSwatch[800], // headlineLargeの文字色は濃い目のエメラルドグリーンで視認性確保
    ),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: customSwatch).copyWith(
    secondary: customSwatch[400], // アクセントカラーは少し明るめのエメラルドグリーン
  ),
);
