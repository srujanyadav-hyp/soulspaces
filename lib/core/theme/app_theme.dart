import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.backgroundDeep,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.silverBlue,
        onPrimary: AppColors.backgroundDeep,
        secondary: AppColors.silverBlueLight,
        onSecondary: AppColors.backgroundDeep,
        surface: AppColors.backgroundCard,
        onSurface: AppColors.doveWhite,
        error: AppColors.errorRed,
      ),
      textTheme: GoogleFonts.loraTextTheme().copyWith(
        displayLarge: AppTextStyles.appTitle,
        bodyLarge: AppTextStyles.responseText,
        bodyMedium: AppTextStyles.hintText,
        labelSmall: AppTextStyles.micLabel,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.appTitle,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.silverBlue,
        size: 24,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),
    );
  }
}
