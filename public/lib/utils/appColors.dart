

import 'package:flutter/material.dart';

class AppColors {
  static Color backgroundColor = Colors.white;
  static List<Color> buttonGradeantColors = [Color(0xFF0072ff), Color(0xFF4594ff)];
  static Color mainTextColor = Color(0xFF111111);
  static Color minorTextColor = Color(0xFF76797b);
  static Color highLightColor = Color(0xFF007FFF);
  static BoxShadow normalShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 16,
    spreadRadius: 8,
    offset: Offset(0, 12)
  );
  static BoxShadow btnShadow = BoxShadow(
    color: buttonGradeantColors.first.withOpacity(0.3),
    blurRadius: 30,
    spreadRadius: -30,
    offset: Offset(0, 45)
  );

  static double getFontSize(double devWidth, double fontSize) {
    return devWidth < 800 ? 800 * fontSize : devWidth > 1200 ? 1200 * fontSize : devWidth * fontSize;
  }
}


// class AppColors {
//   static Color backgroundColor = Color(0xFFebebff);
//   static Color lightBackgroundColor = Color(0xFFffffff);
//   static List<Color> cardGradeantColors = [Color(0xFFffffff), Color(0xFFffffff)];
//   static List<Color> buttonGradeantColors = [Color(0xFF5a65fa), Color(0xFF8e61f7)];
//   static Color mainTextColor = Color(0xFF605eed);
//   static Color minorTextColor = Color(0xFF220b3d).withOpacity(0.8);
//   static BoxShadow boxShadow = BoxShadow(
//     color: buttonGradeantColors.last.withOpacity(0.3),
//     blurRadius: 30,
//     spreadRadius: -30,
//     offset: Offset(0, 45)
//   );

//   static double getFontSize(double devWidth, double fontSize) {
//     return devWidth < 800 ? 800 * fontSize : devWidth > 1200 ? 1200 * fontSize : devWidth * fontSize;
//   }
// }
// class AppColors {
//   static Color backgroundColor = Color(0xFF2e2e3c);
//   static List<Color> shapeGradeantColors = [Color(0xFF2e2e3c), Color(0xFF353548)];
//   static List<Color> cardGradeantColors = [Color(0xFF38384b), Color(0xFF4a4a61)];
//   static List<Color> buttonGradeantColors = [Color(0xFF6669ff), Color(0xFFbf67eb)];
//   static Color mainTextColor = Color(0xFFededfe);
//   static Color minorTextColor = Color(0xFFc9c9d6);
// }