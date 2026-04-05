import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF6C63FF);
  static const primaryLight = Color(0xFF9D97FF);
  static const accent = Color(0xFFFF6584);
  static const accentOrange = Color(0xFFFF9F43);
  static const accentGreen = Color(0xFF1DD1A1);
  static const background = Color(0xFF0F0E17);
  static const surface = Color(0xFF1A1A2E);
  static const surfaceLight = Color(0xFF16213E);
  static const cardBg = Color(0xFF1E1E3A);
  static const textPrimary = Color(0xFFF5F5F5);
  static const textSecondary = Color(0xFFAAAAAA);
  static const textMuted = Color(0xFF666680);
  static const divider = Color(0xFF2A2A4A);

  static const gradientPurple = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF3B37C8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientCard = LinearGradient(
    colors: [Color(0xFF1E1E3A), Color(0xFF16213E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientHero = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
