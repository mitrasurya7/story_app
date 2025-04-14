import 'package:flutter/material.dart';
import 'dart:io';

class PlatformTheme {
  static ThemeData getTheme() {
    if (Platform.isIOS) {
      return _cupertinoTheme;
    } else if (Platform.isLinux) {
      return _yaruTheme;
    } else if (Platform.isWindows) {
      return _fluentTheme;
    }
    return _materialTheme; // default Android
  }

  static final ButtonStyle _defaultButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF3C78D8), // tombol biru
    foregroundColor: Colors.white, // teks putih
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  static final ThemeData _materialTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Color(0xFF3C78D8),
    elevatedButtonTheme: ElevatedButtonThemeData(style: _defaultButtonStyle),
  );

  static final ThemeData _cupertinoTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    fontFamily: 'San Francisco',
    elevatedButtonTheme: ElevatedButtonThemeData(style: _defaultButtonStyle),
  );

  static final ThemeData _yaruTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepOrange,
    fontFamily: 'Ubuntu',
    elevatedButtonTheme: ElevatedButtonThemeData(style: _defaultButtonStyle),
  );

  static final ThemeData _fluentTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blueGrey,
    fontFamily: 'Segoe UI',
    elevatedButtonTheme: ElevatedButtonThemeData(style: _defaultButtonStyle),
  );
}
