import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    backgroundColor: AppColors.white,
    primaryColor: AppColors.blue,
    accentColor: AppColors.orange,
    buttonColor: AppColors.orange,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.darkBlue,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.red,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.darkOrange;
          }

          return AppColors.orange;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.lightGrey;
          }

          return Colors.white;
        }),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.orange),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.red),
      ),
      errorStyle: TextStyle(color: AppColors.red),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.orange,
      unselectedLabelColor: AppColors.lightGrey.withOpacity(0.6),
    ),
  );
}
