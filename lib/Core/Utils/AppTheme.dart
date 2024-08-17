import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/Core/Utils/AppColors.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
appBarTheme:const AppBarTheme(
  iconTheme: IconThemeData(
    color: AppColors.wightColor
  )
),
textTheme: TextTheme(
  titleLarge: GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.wightColor
  ),
  labelMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: AppColors.blackColor
  ),
  bodyLarge: GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor
  ),
  bodySmall: GoogleFonts.roboto(
    fontSize: 12,
    color: AppColors.blackColor,
    fontWeight: FontWeight.normal
  ),
  bodyMedium: GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: AppColors.grayColor
  )
)
  );


}