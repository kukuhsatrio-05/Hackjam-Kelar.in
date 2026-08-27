import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Color Palette: Mascot
  static const Color light = Color(0xFFF2F7FF);
  static const Color lightHover = Color(0xFFEBF3FE);
  static const Color lightActive = Color(0xFFD6E7FE);

  static const Color normal = Color(0xFF7CB2FB);
  static const Color normalHover = Color(0xFF70A0E2);
  static const Color normalActive = Color(0xFF638EC9);

  static const Color dark = Color(0xFF5D86BC);
  static const Color darkHover = Color(0xFF4A6B97);
  static const Color darkActive = Color(0xFF385071);

  static const Color darker = Color(0xFF2B3E58);

  // Semantic Shortcuts (untuk mempermudah Slicing UI)
  static const Color primary = normal;
  static const Color background = Color(0xFFFFFEF9);
  static const Color surface = Colors.white;
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = darkHover;
}
