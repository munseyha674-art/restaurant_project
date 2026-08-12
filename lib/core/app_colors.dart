import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFFF8A3D);
  static const primaryDark = Color(0xFFE86A1C);
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF0F0F4);
  static const cardBorder = Color(0xFFDCDCE2);
  static const textDark = Color(0xFF1C1C21);
  static const textGrey = Color(0xFF6E6E76);
  static const success = Color(0xFF2FBE6E);
  static const danger = Color(0xFFE64545);

  static const primaryGradient = LinearGradient(
    colors: [Color(0xFFFFA35C), Color(0xFFFF7A28)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}