import 'package:flutter/material.dart';

class AppShadows {
  static List<BoxShadow> micIdle = [
    BoxShadow(
      color: const Color(0x50A8C4E0),
      blurRadius: 30,
      spreadRadius: 5,
    ),
  ];

  static List<BoxShadow> micListening = [
    BoxShadow(
      color: const Color(0x706EC6FF),
      blurRadius: 40,
      spreadRadius: 10,
    ),
  ];

  static List<BoxShadow> micSpeaking = [
    BoxShadow(
      color: const Color(0x607DD4B8),
      blurRadius: 35,
      spreadRadius: 8,
    ),
  ];

  static List<BoxShadow> card = [
    BoxShadow(
      color: const Color(0xFF000000),
      blurRadius: 20,
      offset: const Offset(0, 8),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: const Color(0x15A8C4E0),
      blurRadius: 30,
      offset: const Offset(0, 0),
      spreadRadius: 0,
    ),
  ];
}
