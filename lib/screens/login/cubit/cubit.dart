import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/login/cubit/state.dart';
import 'package:news_app/utils/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/network/end_points.dart';
import '../../../utils/utils.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState()) {}

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  var emailController = TextEditingController();

  var passwordController = TextEditingController();



  var db = FirebaseFirestore.instance;
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

  void userLogin() async {
    emit(LoginLoadingState());

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((v) {
            getUserData();

      });
    } on FirebaseAuthException catch (e) {
      print('Error ${e.toString()}');

    } catch (e) {
      print(e);
      emit(LoginErrorState(e.toString()));
    }
  }


  getUserData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String? userPref = await prefs.getString('user');
      Map<String, dynamic>? userData;
      if(userPref != null)
       userData = jsonDecode(userPref);
      UserModel? userDataModel;
if(userData != null) {
  userDataModel = UserModel.fromJson(userData);
      }
      await db
          .collection(EndPoints.userCollection)
          .doc(FirebaseAuth.instance.currentUser?.uid ?? userDataModel?.id)
          .get()
          .then((v) {
       userModel = UserModel.fromJson(v.data()!);
       print('user Data : ${userModel?.toJson()}');
       if(userPref==null){
         prefs.setString('user', jsonEncode(userModel?.toJson()));
       }
        emit(GetUserSuccessState());
      })
          .onError((e, _) {
        print(e);
        emit(LoginErrorState(e.toString()));
      });
    } catch (e) {
      print(e);
      emit(LoginErrorState(e.toString()));
    }
  }

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      final SharedPreferences prefs = await SharedPreferences.getInstance();

     await prefs.remove('user');
      emit(SignOutState());
    } catch (e) {
      print(e);
      emit(LoginErrorState(e.toString()));
    }
  }

}
