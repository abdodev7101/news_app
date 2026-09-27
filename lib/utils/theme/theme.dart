import 'package:flutter/material.dart';

import '../const/colors.dart';

abstract class AppTheme{
 static  final ThemeData lightTheme =  ThemeData(
   scaffoldBackgroundColor: AppColors.white,
   appBarTheme: AppBarTheme(backgroundColor: AppColors.white),
   );


  static final ThemeData darkTheme = ThemeData(
   scaffoldBackgroundColor: AppColors.black,
   appBarTheme: AppBarTheme(backgroundColor: AppColors.black),
   );



}