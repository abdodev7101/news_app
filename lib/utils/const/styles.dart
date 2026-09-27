import 'package:flutter/material.dart';
import 'package:news_app/utils/utils.dart';

import 'colors.dart';

abstract class AppStyles {
  /// Internal helper to determine if dark mode is active


  // ==========================================
  // DYNAMIC TEXT STYLES (All depend on context)
  // ==========================================

  // 14pt
  static TextStyle boldw14(BuildContext context) => TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );

  // 16pt
  static TextStyle bold16(BuildContext context) => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );

  static TextStyle boldw16(BuildContext context) => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );

  // 18pt
  static TextStyle bold(BuildContext context) => TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );

  // 20pt
  static TextStyle bold20(BuildContext context) => TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );

  static TextStyle boldG20(BuildContext context) => TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.grey : AppColors.grey, // Keeps grey or adjust as needed
  );

  static TextStyle boldB20(BuildContext context) => TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );

  static TextStyle boldw20(BuildContext context) => TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );

  static TextStyle boldb20(BuildContext context) => TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );

  // 24pt
  static TextStyle bold24(BuildContext context) => TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );

  static TextStyle boldM24(BuildContext context) => TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );

  static TextStyle boldW24(BuildContext context) => TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );

  // 28pt & 30pt
  static TextStyle bold28(BuildContext context) => TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );

  static TextStyle bold30(BuildContext context) => TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    color: Utils.isDark(context) ? AppColors.white : AppColors.black,
  );
}