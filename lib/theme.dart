import 'package:flutter/material.dart';

ThemeData buildZeusTheme() {
  const primary = Color(0xFFd4af37); // gold
  const dark = Color(0xFF0b0b0b);

  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: primary,
      secondary: primary,
      surface: const Color(0xFF121212),
      onPrimary: Colors.black,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: primary,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );
}

