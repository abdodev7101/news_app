import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/utils/models/user_model.dart';
import 'package:news_app/utils/theme/theme_cubit.dart';

abstract class Utils {
  static navigateTo(screen, context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => screen));
  }

  static navigateToAndFinish(screen, context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => screen));
  }
static  bool isDark(BuildContext context) {

  final themeMode = context.read<ThemeCubit>().state;
  if (themeMode == ThemeMode.system) {
    // Check real OS system brightness
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  return themeMode == ThemeMode.dark;
}
}
UserModel? userModel;
