import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/app_colors.dart';

class MyThemeData {
  static final ThemeData lightMode =ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backGroudLightColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,),

  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.grayColor,
    showUnselectedLabels: false,
    elevation: 0,
    backgroundColor: Colors.transparent
  ) ,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35),
      side: BorderSide(
        color: AppColors.whiteColor,
        width: 6,
      )
    )
  ),
  bottomSheetTheme: BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15)
      ),
      side: BorderSide(
        color: AppColors.blackLightColor,
        width: 4,
      )
    )
  ),

  textTheme:TextTheme(
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: AppColors.whiteColor
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.blackLightColor
  ),
  bodyLarge: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.blackLightColor
  ),
  bodyMedium: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.blackLightColor
  ),
  )

  );


}