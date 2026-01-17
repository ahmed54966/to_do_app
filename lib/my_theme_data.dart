import 'package:flutter/material.dart';
import 'package:to_do_app/app_colors.dart';

class MyThemeData {
  static final ThemeData lightMode =ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backGroudLightColor,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryColor,),
    
  );
}