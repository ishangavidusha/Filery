

import 'package:flutter/material.dart';

class AppColors {
  static Color backgroundColor = Color(0xFFebebff);
  static Color lightBackgroundColor = Color(0xFFffffff);
  static List<Color> cardGradeantColors = [Color(0xFFffffff), Color(0xFFffffff)];
  static List<Color> buttonGradeantColors = [Color(0xFF5a65fa), Color(0xFF8e61f7)];
  static Color mainTextColor = Color(0xFF605eed);
  static Color minorTextColor = Color(0xFF220b3d).withOpacity(0.8);
  static BoxShadow boxShadow = BoxShadow(
    color: buttonGradeantColors.last.withOpacity(0.3),
    blurRadius: 30,
    spreadRadius: -30,
    offset: Offset(0, 45)
  );
}

// class AppColors {
//   static Color backgroundColor = Color(0xFF2e2e3c);
//   static List<Color> shapeGradeantColors = [Color(0xFF2e2e3c), Color(0xFF353548)];
//   static List<Color> cardGradeantColors = [Color(0xFF38384b), Color(0xFF4a4a61)];
//   static List<Color> buttonGradeantColors = [Color(0xFF6669ff), Color(0xFFbf67eb)];
//   static Color mainTextColor = Color(0xFFededfe);
//   static Color minorTextColor = Color(0xFFc9c9d6);
// }