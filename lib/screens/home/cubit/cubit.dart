import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/generated/assets.dart';
import 'package:news_app/screens/home/cubit/state.dart';

import '../../../utils/models/category_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState()) {}

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  List<CategoryModel> categories = [
    CategoryModel(
      titleEn: "General",
      titleAr: "عام",
      backgroundImgDark: Assets.images.generalD.path,
      backgroundImgLight: Assets.images.general.path,
      onTap: () {},
    ),
    CategoryModel(
      titleEn: "Business",
      titleAr: "أعمال",
      backgroundImgDark: Assets.images.busniessD.path,
      backgroundImgLight: Assets.images.busniess.path,
      onTap: () {},
    ),
    CategoryModel(
      titleEn: "Sports",
      titleAr: "رياضة",
      backgroundImgDark: Assets.images.sportD.path,
      backgroundImgLight: Assets.images.sport.path,
      onTap: () {},
    ),
    CategoryModel(
      titleEn: "Technology",
      titleAr: "تكنولوجيا",
      backgroundImgDark: Assets.images.technologyD.path,
      backgroundImgLight: Assets.images.technology.path,
      onTap: () {},
    ),
    CategoryModel(
      titleEn: "Entertainment",
      titleAr: "ترفيه",
      backgroundImgDark: Assets.images.entertainmentD.path,
      backgroundImgLight: Assets.images.entertainment.path,
      onTap: () {},
    ),
    CategoryModel(
      titleEn: "Health ",
      titleAr: "صحة",
      backgroundImgDark: Assets.images.helthD.path,
      backgroundImgLight: Assets.images.helth.path,
      onTap: () {},
    ),
    CategoryModel(
      titleEn: "Science",
      titleAr: "علم",
      backgroundImgDark: Assets.images.scienceD.path,
      backgroundImgLight: Assets.images.science.path,
      onTap: () {},
    ),
  ];
}
