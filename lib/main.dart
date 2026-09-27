import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/login/cubit/cubit.dart';
import 'package:news_app/screens/login/login_screen.dart';
import 'package:news_app/utils/const/app_observer.dart';
import 'package:news_app/utils/const/colors.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => LoginCubit())],
      child: MaterialApp(
        title: 'News App',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          appBarTheme: AppBarTheme(backgroundColor: AppColors.white),
        ),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: AppColors.black,
          appBarTheme: AppBarTheme(backgroundColor: AppColors.black),
        ),
        debugShowCheckedModeBanner: false,

        home: LoginScreen(),
      ),
    );
  }
}
