import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/home/home_screen.dart';
import 'package:news_app/utils/const/colors.dart';
import 'package:news_app/utils/const/styles.dart';
import 'package:news_app/utils/local_service/cubit/local_cubit.dart';
import 'package:news_app/utils/theme/theme_cubit.dart';
import 'package:news_app/utils/utils.dart';

import 'home_drawer_widget.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.white),
            child: Center(
              child: Text(
                'New App',
                style: AppStyles.bold24(
                  context,
                ).copyWith(color: AppColors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.home, color: AppColors.white),
                  title: Text(
                    'Go To Home',
                    style: AppStyles.bold20(
                      context,
                    ).copyWith(color: AppColors.white),
                  ),
                  onTap: () {
                    Utils.navigateToAndFinish(HomeScreen(), context);
                  },
                ),
                Divider(color: AppColors.white),

                HomeDrawerWidget(
                  title: 'Theme',
                  initValue: context.read<ThemeCubit>().state == ThemeMode.light?'Light':'Dark',
                  iconTitle: Icons.dark_mode,
                  items: [
                    DropdownMenuItem(value: 'Light', child: Text('Light')),
                    DropdownMenuItem(value: 'Dark', child: Text('Dark')),
                  ],
                  onChanged: (value) {
                    context.read<ThemeCubit>().setTheme(
                      value == 'Light' ? ThemeMode.light : ThemeMode.dark,
                    );

                  },
                ),

                Divider(color: AppColors.white),

                HomeDrawerWidget(
                  title: 'Language',
                  iconTitle: Icons.language,
                  initValue: context.read<LocaleCubit>().state.languageCode,
                  items: [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'ar', child: Text('Arabic')),
                  ],
                  onChanged: (value) {
context.read<LocaleCubit>().toggleLocale();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
