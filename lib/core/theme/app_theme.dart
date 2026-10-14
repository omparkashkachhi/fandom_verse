// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class AppTheme {
//   static const Color deepSpace = Color(0xFF080120);
//   static const Color purple = Color(0xFF7C3AED);
//   static const Color blue = Color(0xFF2563EB);
//   static const Color cyan = Color(0xFF22DDEE);
//   static const Color pink = Color(0xFFEC4899);
//
//   static ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: deepSpace,
//
//     colorScheme: ColorScheme.dark(
//       primary: purple,
//       secondary: cyan,
//       surface: const Color(0xFF11152B),
//     ),
//
//     textTheme: GoogleFonts.poppinsTextTheme(
//       ThemeData.dark().textTheme,
//     ),
//
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       centerTitle: false,
//     ),
//
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: const Color(0xFF151B36),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide.none,
//       ),
//     ),
//
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//       backgroundColor: Color(0xFF0D1024),
//       selectedItemColor: purple,
//       unselectedItemColor: Colors.white54,
//       type: BottomNavigationBarType.fixed,
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.pink,
        surface: AppColors.cardBg,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.dark().textTheme,
      ),
      useMaterial3: true,
    );
  }
}