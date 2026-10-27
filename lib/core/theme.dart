import 'package:flutter/material.dart';

class C {
  static const bg = Color(0xFFF6F6FA), ink = Color(0xFF14141F), muted = Color(0xFF6B6B7B);
  static const yellow = Color(0xFFFFF4B8), accent = Color(0xFFFFE500), lime = Color(0xFFE8FBB5);
  static const mint = Color(0xFFCFFBD6), lilac = Color(0xFFD3C8FF), peach = Color(0xFFFFE3B8);
  static const chip = Color(0xFFF1F1F6), orange = Color(0xFFFF9500);
}

class Sp {
  static const page = 20.0, gap = 16.0, radius = 28.0;
}

ThemeData appTheme() => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: C.bg,
      colorSchemeSeed: C.lilac,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: C.ink),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: C.ink),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: C.ink),
        bodyMedium: TextStyle(fontSize: 14, color: C.ink),
        bodySmall: TextStyle(fontSize: 12, color: C.muted),
      ),
    );
