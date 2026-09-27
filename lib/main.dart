import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:news_app/screens/home/cubit/cubit.dart';
import 'package:news_app/screens/home/home_screen.dart';
import 'package:news_app/screens/login/cubit/cubit.dart';
import 'package:news_app/screens/login/login_screen.dart';
import 'package:news_app/utils/const/app_observer.dart';
import 'package:news_app/utils/const/colors.dart';
import 'package:news_app/utils/local_service/cubit/local_cubit.dart';
import 'package:news_app/utils/local_service/local_service.dart';
import 'package:news_app/utils/models/user_model.dart';
import 'package:news_app/utils/theme/theme.dart';
import 'package:news_app/utils/theme/theme_cubit.dart';
import 'package:news_app/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
        (await getTemporaryDirectory()).path),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  String? userPref = await prefs.getString('user');
  Map<String, dynamic>? userData;
  if (userPref != null)
    userData = jsonDecode(userPref);
  print('user Pref : ${userPref}');
  if (userData != null) {
    print('user Data : ${userData}');
    userModel = UserModel.fromJson(userData);
    print('user userModel : ${userModel?.toJson()}');
  }


  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              print(locale.languageCode);
              return MaterialApp(
                title: 'News App',
                themeMode: state,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                debugShowCheckedModeBanner: false,
                locale: locale,

                supportedLocales: const [
                  Locale('en', ''), // English
                  Locale('ar', ''), // Arabic
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                builder: (context, child) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                    child: child ?? SizedBox(),
                  );
                },
                home: FirebaseAuth.instance.currentUser != null &&
                    userModel != null
                    ? HomeScreen()
                    : LoginScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
