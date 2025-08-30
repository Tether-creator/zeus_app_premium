import 'package:flutter/material.dart';

class ZeusColors {
  static const background = Color(0xFF0E2934); // deep blue
  static const surface = Color(0xFF143543);
  static const onBackground = Color(0xFFE7F0F4);
  static const onSurface = Color(0xFFD7E6EC);
  static const gold = Color(0xFFD9B24D);
  static const goldPressed = Color(0xFFBF9C43);
  static const divider = Color(0xFF2A4956);
  static const success = Color(0xFF1FB879);
  static const error = Color(0xFFEF5350);
  static const muted = Color(0xFF9FB6BF);
}

ThemeData buildZeusTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: ZeusColors.background,
    colorScheme: base.colorScheme.copyWith(
      brightness: Brightness.dark,
      primary: ZeusColors.gold,
      surface: ZeusColors.surface,
      background: ZeusColors.background,
      onSurface: ZeusColors.onSurface,
      onBackground: ZeusColors.onBackground,
      secondary: ZeusColors.gold,
      error: ZeusColors.error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ZeusColors.background,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: ZeusColors.onBackground,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: ZeusColors.onBackground),
    ),
    dividerColor: ZeusColors.divider,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: ZeusColors.gold,
        foregroundColor: Colors.black,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ).copyWith(
        overlayColor: WidgetStateProperty.all(ZeusColors.goldPressed),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ZeusColors.surface,
        foregroundColor: ZeusColors.onSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ZeusColors.surface,
      hintStyle: const TextStyle(color: ZeusColors.muted),
      labelStyle: const TextStyle(color: ZeusColors.muted),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ZeusColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ZeusColors.gold, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ZeusColors.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: ZeusColors.gold,
      textColor: ZeusColors.onSurface,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: ZeusColors.onSurface,
      displayColor: ZeusColors.onSurface,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ZeusColors.surface,
      selectedItemColor: ZeusColors.gold,
      unselectedItemColor: ZeusColors.muted,
      type: BottomNavigationBarType.fixed,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: ZeusColors.surface,
      contentTextStyle: TextStyle(color: ZeusColors.onSurface),
      behavior: SnackBarBehavior.floating,
    ),
    cardTheme: CardTheme(
      color: ZeusColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
  );
}
