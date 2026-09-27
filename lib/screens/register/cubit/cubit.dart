import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/register/cubit/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/utils/models/user_model.dart';
import 'package:news_app/utils/network/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of<RegisterCubit>(context);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var db = FirebaseFirestore.instance;
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  void userRegister() async {
    emit(RegisterLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
        .then((v) {
          registerUserData(credential: v);
        });
    try {} on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        emit(RegisterErrorState('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        emit(RegisterErrorState('The account already exists for that email.'));
      }
    } catch (e) {
      print(e);
      emit(RegisterErrorState(e.toString()));
    }
  }

  registerUserData({required UserCredential credential}) async {
    try {
      await db
          .collection(EndPoints.userCollection)
          .add({
            "name": nameController.text,
            'phone': phoneController.text,
            "email": emailController.text,
          })
          .then((v) {
            v.update({"id": v.id}).then((vv) async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              UserModel user = UserModel(
                id: v.id,
                email: emailController.text,
                name: nameController.text,
                phone: phoneController.text,
              );
              prefs.setString('user', jsonEncode(user.toJson()));
              
              emit(RegisterSuccessState());
            });
          })
          .onError((e, _) {
            print(e);
            emit(RegisterErrorState(e.toString()));
          });
    } catch (e) {
      print(e);
      emit(RegisterErrorState(e.toString()));
    }
  }

  getUserData() async {
    try {
      await db
          .collection(EndPoints.userCollection)
          .doc()
          .get()
          .then((v) {
            emit(RegisterSuccessState());
          })
          .onError((e, _) {
            print(e);
            emit(RegisterErrorState(e.toString()));
          });
    } catch (e) {
      print(e);
      emit(RegisterErrorState(e.toString()));
    }
  }
}
