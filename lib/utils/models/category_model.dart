import 'package:flutter/material.dart';

class CategoryModel {
  String titleAr;
  String titleEn;
  String backgroundImgLight;
  String backgroundImgDark;
  VoidCallback onTap;

  CategoryModel({
    required this.titleAr,
    required this.titleEn,
    required this.backgroundImgLight,
    required this.backgroundImgDark,
    required this.onTap,
  });
}
