import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/generated/assets.dart';
import 'package:news_app/screens/home/cubit/state.dart';
import 'package:news_app/screens/news/models/news_model.dart';
import 'package:news_app/utils/network/dio_serves.dart';

import '../../../utils/models/category_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState()) {}

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  int selectedSourceIndex = 0;

  List<CategoryModel> categories = [
    CategoryModel(
      titleEn: "General",
      titleAr: "عام",
      backgroundImgDark: Assets.images.generalD.path,
      backgroundImgLight: Assets.images.general.path,
    ),
    CategoryModel(
      titleEn: "Business",
      titleAr: "أعمال",
      backgroundImgDark: Assets.images.busniessD.path,
      backgroundImgLight: Assets.images.busniess.path,
    ),
    CategoryModel(
      titleEn: "Sports",
      titleAr: "رياضة",
      backgroundImgDark: Assets.images.sportD.path,
      backgroundImgLight: Assets.images.sport.path,
    ),
    CategoryModel(
      titleEn: "Technology",
      titleAr: "تكنولوجيا",
      backgroundImgDark: Assets.images.technologyD.path,
      backgroundImgLight: Assets.images.technology.path,
    ),
    CategoryModel(
      titleEn: "Entertainment",
      titleAr: "ترفيه",
      backgroundImgDark: Assets.images.entertainmentD.path,
      backgroundImgLight: Assets.images.entertainment.path,
    ),
    CategoryModel(
      titleEn: "Health ",
      titleAr: "صحة",
      backgroundImgDark: Assets.images.helthD.path,
      backgroundImgLight: Assets.images.helth.path,
    ),
    CategoryModel(
      titleEn: "Science",
      titleAr: "علم",
      backgroundImgDark: Assets.images.scienceD.path,
      backgroundImgLight: Assets.images.science.path,
    ),
  ];
  NewsModel? newsModel;
  List<Source>? sources = [];
  List<Articles>? articles = [];

  Future<void> fetchNewsByCategory({required String category}) async {
    emit(GetNewsLoadingState());

    try {
      newsModel = null;
      sources?.clear();
      sources=[];
      articles?.clear();
      articles=[];
      final Response responce = await DioServes.getNewsData(
        query: {'q': category},
      );
      newsModel = NewsModel.fromJson(responce.data);
      newsModel?.articles?.forEach((article) {
        final source = article.source;

        if (source != null && source.name != null) {
          bool exists = sources?.any((element) => element.name == source.name) ?? false;

          if (!exists) {
            print('added ${source.name}');
            sources?.add(source);
          }
        }
      });
      newsModel?.articles?.forEach((article) {
       if(article.source != null) {
         if (article.source!.name == sources!.first.name) {
           articles?.add(article);
         }
       }
      });

      emit(GetNewsSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetNewsErrorState(e.toString()));
    }
  }

  String formateDate(date) {
    DateTime parsedDate = DateTime.parse(date);
    DateTime localDate = parsedDate.toLocal();
    return DateFormat('yyyy-MM-dd hh:mm a').format(localDate);
  }

  void selectSource(index){
    selectedSourceIndex = index;
    articles = [];
    newsModel?.articles?.forEach((article) {
      if(article.source != null) {
        if (article.source!.name == sources![index].name) {
          articles?.add(article);
        }
      }
    });

    emit(ChangeSourceState());
  }

}
