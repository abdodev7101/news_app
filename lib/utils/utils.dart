import 'package:flutter/material.dart';
import 'package:news_app/utils/models/user_model.dart';

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

}
UserModel? userModel;
