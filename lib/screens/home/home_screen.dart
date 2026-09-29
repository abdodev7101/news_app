import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/home/cubit/cubit.dart';
import 'package:news_app/screens/home/cubit/state.dart';
import 'package:news_app/screens/home/widgets/category_widget.dart';
import 'package:news_app/screens/home/widgets/home_drawer.dart';
import 'package:news_app/utils/local_service/local_service.dart';

import '../../utils/const/colors.dart';
import '../../utils/const/styles.dart';
import '../../utils/local_service/key_string.dart';
import '../../utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          drawer:HomeDrawer(),
          appBar: AppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu,color: Utils.isDark(context) ? AppColors.white : AppColors.black,),
                );
              },
            ),


            centerTitle: true,
            title: Text(
              '${AppLocalizations.of(context)!.translate(keyString.home)}',
              style: AppStyles.bold24(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text( '${AppLocalizations.of(context)!.translate(keyString.good_morrning)}',
                  style: AppStyles.boldM24(context),
                textAlign: TextAlign.center,
                ),
               SizedBox(height: 20,),
                Expanded(
                  child: ListView.separated(itemBuilder: (context, index) {
                    return  CategoryWidget(category: cubit.categories[index], ifRight: index%2==0,);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: cubit.categories.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
