# DESIGN_SYSTEM.md — Telugu Spiritual Confessional App

---

## Design Direction

**Aesthetic**     : Heavenly Modern — Deep navy with silver-blue divine light
**Mood**          : Like looking at the night sky just before dawn — deep, peaceful, holy
**Inspired By**   : The app logo — deep navy background, silver-blue metallic cross, Bible, and dove
**One Word**      : CELESTIAL
**Theme Mode**    : Dark only (no light mode)
**What makes it unforgettable**: The feeling that heaven is close — deep navy depths with
                  glowing silver-blue light, as if divine light is breaking through darkness

---

## Color Palette (Extracted from Logo)

```dart
// ─────────────────────────────────────────────
// app_colors.dart
// ─────────────────────────────────────────────

class AppColors {

  // ── BACKGROUNDS ──────────────────────────────
  // Deep navy — exact background from logo
  static const Color backgroundDeep     = Color(0xFF0D1628);  // Main screen background
  static const Color backgroundMid      = Color(0xFF112038);  // Slightly lighter layer
  static const Color backgroundCard     = Color(0xFF162440);  // Cards and containers
  static const Color backgroundElevated = Color(0xFF1C2E4A);  // Elevated surfaces, dialogs

  // ── SILVER BLUE — Primary Accent ─────────────
  // Extracted from the metallic logo shine
  static const Color silverBlue         = Color(0xFFA8C4E0);  // Main accent — logo base color
  static const Color silverBlueLight    = Color(0xFFD0E8FF);  // Bright metallic highlight
  static const Color silverBlueDim      = Color(0xFF5A7FA0);  // Dimmed — borders, inactive icons
  static const Color silverBlueGhost    = Color(0xFF2A4060);  // Very dim — subtle backgrounds

  // ── DOVE WHITE — Pure Light ───────────────────
  // Extracted from the dove in the logo
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
```

---

## Gradient Definitions

```dart
// ─────────────────────────────────────────────
// app_gradients.dart
// ─────────────────────────────────────────────

class AppGradients {

  // Main background gradient — deep navy top to slightly lighter bottom
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0A1220), Color(0xFF0D1628), Color(0xFF112038)],
    stops: [0.0, 0.5, 1.0],
  );

  // Silver blue metallic — for logo, mic button, dividers
  static const LinearGradient silverMetallic = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD0E8FF), Color(0xFFA8C4E0), Color(0xFF5A7FA0)],
    stops: [0.0, 0.5, 1.0],
  );

  // Mic button gradient — idle state
  static const LinearGradient micIdleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD0E8FF), Color(0xFF7AAFD4)],
  );

  // Mic button gradient — listening state
  static const LinearGradient micListeningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6EC6FF), Color(0xFF3A9FE0)],
  );

  // Response card gradient — subtle depth
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF162440), Color(0xFF112038)],
  );

  // Divine light radial — center glow effect on idle screen
  static const RadialGradient divineGlow = RadialGradient(
    center: Alignment.center,
    radius: 0.6,
    colors: [Color(0x25A8C4E0), Color(0x00000000)],
  );
}
```

---

## Typography — Google Fonts

### Font Strategy
- **Display**  : Elegant serif — sacred, timeless, authoritative (app title, headings)
- **Body**     : Clean humanist — warm and highly readable for Telugu scripture text
- **Label**    : Thin geometric — mic labels, status text, captions

### Chosen Fonts

#### 1. Cinzel — Display / Title Font
```
Usage     : App name, screen title, major headings
Style     : Roman-inspired serif, regal and divine
Why       : Looks like it was carved in stone — timeless authority
Google    : https://fonts.google.com/specimen/Cinzel
Weight    : 400 (Regular), 600 (SemiBold)
```

#### 2. Lora — Body / Response Text Font
```
Usage     : God's response text, Bible verse display
Style     : Contemporary serif with brushstroke elegance
Why       : Warm, readable, feels like reading scripture
Google    : https://fonts.google.com/specimen/Lora
Weight    : 400 (Regular), 500 (Medium), 600 (SemiBold Italic for verses)
```

#### 3. Nunito — UI / Label Font
```
Usage     : Mic button label, status messages, hints, captions
Style     : Rounded sans-serif — friendly and clean
Why       : Balances the heavy serif fonts — soft and approachable
Google    : https://fonts.google.com/specimen/Nunito
Weight    : 300 (Light), 400 (Regular), 600 (SemiBold)
```

### Telugu Font Rendering Note
```
Flutter renders Telugu script using the device's system font (Noto Sans Telugu).
Google Fonts above apply to English UI elements only.
Telugu response text will render in system Telugu font — ensure text size is
minimum 16sp for comfortable Telugu reading.
```

### pubspec.yaml — Font Setup
```yaml
dependencies:
  google_fonts: ^6.2.1

# No need to manually declare font assets — google_fonts package handles it
```

### Usage in Code
```dart
// app_text_styles.dart

import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {

  // App Title — "దైవ వాక్యం" or app name
  static TextStyle appTitle = GoogleFonts.cinzel(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.silverBlueLight,
    letterSpacing: 3.0,
  );

  // Screen Subtitle
  static TextStyle subtitle = GoogleFonts.cinzel(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.doveWhiteSoft,
    letterSpacing: 2.0,
  );

  // God's Response — Main body text (Telugu)
  static TextStyle responseText = GoogleFonts.lora(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.doveWhite,
    height: 1.85,          // Generous line height for Telugu script
    letterSpacing: 0.3,
  );

  // Bible Verse — Highlighted reference
  static TextStyle bibleVerse = GoogleFonts.lora(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: AppColors.silverBlueLight,
    height: 1.7,
  );

  // Bible Reference Tag (e.g., "యోహాను 3:16")
  static TextStyle bibleReference = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.silverBlueDim,
    letterSpacing: 1.2,
  );

  // Mic button label
  static TextStyle micLabel = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.doveWhiteSoft,
    letterSpacing: 1.0,
  );

  // Status text (Listening... / Processing... / Speaking...)
  static TextStyle statusText = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppColors.doveWhiteSoft,
    letterSpacing: 1.5,
  );

  // Hint / empty state text
  static TextStyle hintText = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppColors.doveWhiteGhost,
    letterSpacing: 0.5,
  );
}
```

---

## Spacing System

```dart
// app_spacing.dart

class AppSpacing {

  // Base unit = 4dp (Flutter standard)

  static const double xs   =  4.0;   // Tight — icon padding, badge
  static const double sm   =  8.0;   // Small — between icon and label
  static const double md   = 16.0;   // Medium — standard padding inside cards
  static const double lg   = 24.0;   // Large — between sections
  static const double xl   = 32.0;   // Extra large — top/bottom screen padding
  static const double xxl  = 48.0;   // Section breathing room
  static const double xxxl = 64.0;   // Hero section spacing (above mic button)

  // Screen Horizontal Padding
  static const double screenPadding = 24.0;

  // Card Internal Padding
  static const double cardPadding   = 20.0;

  // Mic button area — bottom safe zone
  static const double micAreaHeight  = 160.0;
  static const double micButtonSize  = 80.0;
  static const double micButtonInner = 56.0;  // Inner icon size
}
```

---

## Border Radius System

```dart
// app_radius.dart

class AppRadius {
  static const double xs     =  4.0;   // Chips, small tags
  static const double sm     =  8.0;   // Small buttons
  static const double md     = 12.0;   // Cards, containers
  static const double lg     = 16.0;   // Response card
  static const double xl     = 24.0;   // Bottom sheet, modals
  static const double round  = 999.0;  // Mic button (full circle)
}
```

---

## Elevation & Shadow System

```dart
// app_shadows.dart

class AppShadows {

  // Mic button — idle glow
  static List<BoxShadow> micIdle = [
    BoxShadow(
      color: Color(0x50A8C4E0),
      blurRadius: 30,
      spreadRadius: 5,
    ),
  ];

  // Mic button — listening pulse glow
  static List<BoxShadow> micListening = [
    BoxShadow(
      color: Color(0x706EC6FF),
      blurRadius: 40,
      spreadRadius: 10,
    ),
  ];

  // Mic button — speaking glow
  static List<BoxShadow> micSpeaking = [
    BoxShadow(
      color: Color(0x607DD4B8),
      blurRadius: 35,
      spreadRadius: 8,
    ),
  ];

  // Response card shadow
  static List<BoxShadow> card = [
    BoxShadow(
      color: Color(0xFF000000),
      blurRadius: 20,
      offset: Offset(0, 8),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x15A8C4E0),
      blurRadius: 30,
      offset: Offset(0, 0),
      spreadRadius: 0,
    ),
  ];
}
```

---

## Icon System

```dart
// All icons should feel sacred and minimal
// Use outlined style — never filled (feels heavy)

class AppIcons {
  // Mic states
  static const IconData micOff       = Icons.mic_none_outlined;
  static const IconData micOn        = Icons.mic_outlined;

  // Spiritual icons (use as decoration)
  static const IconData cross        = Icons.add;             // Rotated 0° — use custom SVG instead
  static const IconData book         = Icons.menu_book_outlined;
  static const IconData dove         = Icons.send_outlined;   // Use custom SVG asset for dove

  // UI icons
  static const IconData replay       = Icons.replay_outlined;
  static const IconData close        = Icons.close;
  static const IconData volumeUp     = Icons.volume_up_outlined;
}

// Recommended: Use the app logo (cross + bible + dove) as a decorative
// watermark asset in the center of the screen during idle state
// File: assets/images/logo.png (the uploaded logo image)
```

---

## Flutter ThemeData Setup

```dart
// app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,

      // Scaffold
      scaffoldBackgroundColor: AppColors.backgroundDeep,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.silverBlue,
        onPrimary: AppColors.backgroundDeep,
        secondary: AppColors.silverBlueLight,
        onSecondary: AppColors.backgroundDeep,
        surface: AppColors.backgroundCard,
        onSurface: AppColors.doveWhite,
        error: AppColors.errorRed,
        background: AppColors.backgroundDeep,
        onBackground: AppColors.doveWhite,
      ),

      // Text Theme
      textTheme: GoogleFonts.loraTextTheme().copyWith(
        displayLarge: AppTextStyles.appTitle,
        bodyLarge: AppTextStyles.responseText,
        bodyMedium: AppTextStyles.hintText,
        labelSmall: AppTextStyles.micLabel,
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.appTitle,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.silverBlue,
        size: 24,
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),
    );
  }
}
```

---

## Animation Constants

```dart
// app_animations.dart

class AppAnimations {

  // Duration
  static const Duration fast     = Duration(milliseconds: 200);
  static const Duration normal   = Duration(milliseconds: 400);
  static const Duration slow     = Duration(milliseconds: 700);
  static const Duration verySlow = Duration(milliseconds: 1200);

  // Mic pulse animation (listening state)
  // Repeat: scale 1.0 → 1.15 → 1.0, duration: 900ms, curve: easeInOut

  // Divine glow pulse (idle state)
  // Repeat: opacity 0.3 → 0.7 → 0.3, duration: 2500ms, curve: easeInOut

  // Response text fade in
  // Once: opacity 0.0 → 1.0, translateY 20 → 0, duration: 700ms, curve: easeOut

  // Speaking wave animation
  // 3 concentric circles expanding outward from mic button
  // opacity 0.6 → 0.0, scale 1.0 → 2.0, stagger: 400ms each
}
```

---

## Assets Folder Structure

```
assets/
  images/
    logo.png              ← The uploaded app logo (cross + bible + dove)
    logo_small.png        ← Smaller version for AppBar
  fonts/                  ← Not needed (using google_fonts package)
  audio/                  ← (future — custom TTS audio files)
```

### pubspec.yaml — Assets Setup
```yaml
flutter:
  assets:
    - assets/images/logo.png
    - assets/images/logo_small.png
  uses-material-design: true
```

---

## Screen Layout Blueprint

```
┌─────────────────────────────┐
│         [App Bar]           │  ← Transparent, app name in Cinzel font
│                             │
│                             │
│       [Logo / Cross]        │  ← Centered, dim watermark (idle state)
│    (divine glow pulse)      │  ← Subtle radial glow behind logo
│                             │
│   ┌─────────────────────┐   │
│   │  Response Text Area │   │  ← Lora font, scrollable, fades in
│   │  (Telugu scripture) │   │  ← Bible verse in silver blue italic
│   └─────────────────────┘   │
│                             │
│                             │
│         ● MIC ●             │  ← Large circle button, bottom center
│     [Status Label]          │  ← "మాట్లాడండి..." in Nunito
│                             │
└─────────────────────────────┘
```

---

## Color Quick Reference Card

```
BACKGROUND    #0D1628  ██  Deep Navy
CARD          #162440  ██  Dark Navy
ACCENT        #A8C4E0  ██  Silver Blue
ACCENT LIGHT  #D0E8FF  ██  Pearl White Blue
ACCENT DIM    #5A7FA0  ██  Steel Blue
TEXT PRIMARY  #F0F6FF  ██  Dove White
TEXT SOFT     #B8CCDF  ██  Muted Silver
MIC IDLE      #A8C4E0  ██  Silver Blue
MIC LISTEN    #6EC6FF  ██  Sky Blue
MIC PROCESS   #8BA7FF  ██  Soft Indigo
MIC SPEAK     #7DD4B8  ██  Soft Teal
```
