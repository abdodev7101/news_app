import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/home/cubit/cubit.dart';
import 'package:news_app/screens/home/cubit/state.dart';
import 'package:news_app/screens/news/widgets/news_details_screen.dart';
import 'package:news_app/utils/local_service/local_service.dart';
import 'package:news_app/utils/models/category_model.dart';

import '../../utils/const/colors.dart';
import '../../utils/const/styles.dart';
import '../../utils/utils.dart';
import '../home/widgets/home_drawer.dart';
import 'models/news_model.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key, required this.categoryModel});

  final CategoryModel? categoryModel;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByCategory();
  }

  getNewsByCategory() async {
    await HomeCubit.get(
      context,
    ).fetchNewsByCategory(category: widget.categoryModel?.titleEn ?? 'general');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          drawer: HomeDrawer(),
          appBar: AppBar(
            centerTitle: true,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Utils.isDark(context)
                        ? AppColors.white
                        : AppColors.black,
                  ),
                );
              },
            ),
            title: Text(
              AppLocalizations.of(context)?.locale.languageCode == 'en'
                  ? widget.categoryModel?.titleEn ?? 'General'
                  : widget.categoryModel?.titleAr ?? 'عام',
              style: AppStyles.bold20(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Utils.isDark(context)
                      ? AppColors.white
                      : AppColors.black,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: state is GetNewsLoadingState && cubit.newsModel == null
              ? Center(child: CircularProgressIndicator(color: AppColors.white))
              : Column(
                  children: [
                    // Horizontal Source Tabs
                    Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: cubit.sources?.length,
                        itemBuilder: (context, index) {
                          final isSelected = cubit.selectedSourceIndex == index;
                          return GestureDetector(
                            onTap: () {
                              cubit.selectSource(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                border: isSelected
                                    ? const Border(
                                        bottom: BorderSide(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                      )
                                    : null,
                              ),
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                cubit.sources?[index].name ?? '',
                                style: isSelected
                                    ? AppStyles.bold16(context)
                                    : AppStyles.boldG20(
                                        context,
                                      ).copyWith(fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Article List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: cubit.articles?.length,
                        itemBuilder: (context, index) {
                          return _buildNewsCard(cubit.articles![index], cubit);
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildNewsCard(Articles article, HomeCubit cubit) {
    return GestureDetector(
      onTap: () {
        openBottomSheet(context, article);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.white.withOpacity(0.6), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                article.urlToImage ?? '',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: AppColors.grey,
                    child: const Icon(Icons.broken_image, size: 50),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    article.title ?? '',
                    style: AppStyles.bold16(context),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Author and Date Info Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          'By : ${article.author ?? "Unknown"}',
                          style: AppStyles.boldG20(
                            context,
                          ).copyWith(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        cubit.formateDate(article.publishedAt) ?? '',
                        style: AppStyles.boldG20(context).copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openBottomSheet(context, Articles article) {
    showModalBottomSheet(
      context: context,constraints: BoxConstraints(
        maxHeight: 370,
   maxWidth: MediaQuery.of(context).size.width-20,
      ),
      builder: (context) {
        return Container(
          height: 370,

          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // News Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  article.urlToImage ?? '',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: AppColors.grey,
                      child: const Icon(Icons.broken_image, size: 50),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  article.content ?? '',
                  style: AppStyles.bold16(context).copyWith(color: AppColors.black),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.black,
                        ),
                        onPressed: () {
                          Utils.navigateTo(NewsDetailsScreen(url: article.url ?? ''), context);
                        }, child:  Text('View Full Article',  style: AppStyles.bold16(context)))),
                  ],
                ),
              ),
            ],
          ) ,
        );
      },
    );
  }
}
