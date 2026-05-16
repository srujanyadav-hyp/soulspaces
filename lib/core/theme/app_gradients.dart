import 'package:flutter/material.dart';

class AppGradients {
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0A1220), Color(0xFF0D1628), Color(0xFF112038)],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient silverMetallic = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD0E8FF), Color(0xFFA8C4E0), Color(0xFF5A7FA0)],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient micIdleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD0E8FF), Color(0xFF7AAFD4)],
  );

  static const LinearGradient micListeningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6EC6FF), Color(0xFF3A9FE0)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF162440), Color(0xFF112038)],
  );

  static const RadialGradient divineGlow = RadialGradient(
    center: Alignment.center,
    radius: 0.6,
    colors: [Color(0x25A8C4E0), Color(0x00000000)],
  );
}
