import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle appTitle = GoogleFonts.cinzel(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.silverBlueLight,
    letterSpacing: 3.0,
  );

  static TextStyle subtitle = GoogleFonts.cinzel(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.doveWhiteSoft,
    letterSpacing: 2.0,
  );

  static TextStyle responseText = GoogleFonts.lora(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.doveWhite,
    height: 1.85,
    letterSpacing: 0.3,
  );

  static TextStyle bibleVerse = GoogleFonts.lora(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: AppColors.silverBlueLight,
    height: 1.7,
  );

  static TextStyle bibleReference = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.silverBlueDim,
    letterSpacing: 1.2,
  );

  static TextStyle micLabel = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.doveWhiteSoft,
    letterSpacing: 1.0,
  );

  static TextStyle statusText = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppColors.doveWhiteSoft,
    letterSpacing: 1.5,
  );

  static TextStyle hintText = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppColors.doveWhiteGhost,
    letterSpacing: 0.5,
  );
}
