import 'package:bmi_calculator/core/theme/app_clolors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.backgroundColor,

    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: AppColors.textPrimary,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: const CardThemeData(
      elevation: 0,
      color: AppColors.card,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: false,
      border: InputBorder.none,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.primary,
        disabledForegroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(0),
            bottom: Radius.circular(24),
          ),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      surface: AppColors.card,
      onSurface: AppColors.textPrimary,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      tertiary: AppColors.transparent,
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: Colors.white,
      inactiveTrackColor: AppColors.control,
      thumbColor: AppColors.primary,
      overlayColor: Color(0x33E70D50),
    ),
  );
}
