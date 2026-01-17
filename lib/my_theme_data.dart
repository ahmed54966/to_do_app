import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/app_colors.dart';

class MyThemeData {
  static final ThemeData lightMode =ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backGroudLightColor,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryColor,),

  textTheme:TextTheme(
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColors.whiteColor
    )
  ),

  );


}