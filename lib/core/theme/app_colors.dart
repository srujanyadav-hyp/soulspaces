import 'package:flutter/material.dart';

class AppColors {
  // ── BACKGROUNDS ──────────────────────────────
  static const Color backgroundDeep     = Color(0xFF0D1628);  // Main screen background
  static const Color backgroundMid      = Color(0xFF112038);  // Slightly lighter layer
  static const Color backgroundCard     = Color(0xFF162440);  // Cards and containers
  static const Color backgroundElevated = Color(0xFF1C2E4A);  // Elevated surfaces, dialogs

  // ── SILVER BLUE — Primary Accent ─────────────
  static const Color silverBlue         = Color(0xFFA8C4E0);  // Main accent — logo base color
  static const Color silverBlueLight    = Color(0xFFD0E8FF);  // Bright metallic highlight
  static const Color silverBlueDim      = Color(0xFF5A7FA0);  // Dimmed — borders, inactive icons
  static const Color silverBlueGhost    = Color(0xFF2A4060);  // Very dim — subtle backgrounds

  // ── DOVE WHITE — Pure Light ───────────────────
  static const Color doveWhite          = Color(0xFFF0F6FF);  // Pure text — main response text
  static const Color doveWhiteSoft      = Color(0xFFB8CCDF);  // Soft text — subtitles, hints
  static const Color doveWhiteGhost     = Color(0xFF607080);  // Ghost text — placeholders

  // ── MIC BUTTON STATES ─────────────────────────
  static const Color micIdle            = Color(0xFFA8C4E0);  // Silver blue — waiting
  static const Color micListening       = Color(0xFF6EC6FF);  // Bright blue — actively listening
  static const Color micProcessing      = Color(0xFF8BA7FF);  // Soft indigo — AI thinking
  static const Color micSpeaking        = Color(0xFF7DD4B8);  // Soft teal-green — God speaking

  // ── GLOW / AURA (for animations) ─────────────
  static const Color glowSilver         = Color(0x35A8C4E0);  // Silver glow — idle aura
  static const Color glowBlue           = Color(0x406EC6FF);  // Blue glow — listening aura
  static const Color glowIndigo         = Color(0x408BA7FF);  // Indigo glow — processing aura
  static const Color glowTeal           = Color(0x407DD4B8);  // Teal glow — speaking aura
  static const Color glowWhite          = Color(0x20F0F6FF);  // White glow — divine light pulse

  // ── BORDERS & DIVIDERS ───────────────────────
  static const Color borderSubtle       = Color(0xFF1E3050);  // Subtle container borders
  static const Color borderSilver       = Color(0x50A8C4E0);  // Silver semi-transparent border
  static const Color divider            = Color(0xFF1A2A40);  // Section dividers

  // ── STATUS / FEEDBACK ────────────────────────
  static const Color errorRed           = Color(0xFFFF6B6B);  // Error state
  static const Color successGreen       = Color(0xFF7DD4B8);  // Success / speaking state
}
