import 'package:flutter/material.dart';
import 'package:news_app/utils/const/styles.dart';
import 'package:news_app/utils/models/category_model.dart';
import 'package:news_app/utils/utils.dart';

import '../../../utils/const/colors.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  final bool ifRight;


  const CategoryWidget({
    Key? key,
    required this.category,
    required this.ifRight,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isRtlLocal = Directionality.of(context) == TextDirection.rtl;
    return Container(
      padding: EdgeInsets.all(20),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(Utils.isDark(context) ? category.backgroundImgLight : category.backgroundImgDark),
          fit: BoxFit.cover,

        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment:ifRight?isRtlLocal? CrossAxisAlignment.start: CrossAxisAlignment.end:isRtlLocal? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              category.titleEn,
              style: AppStyles.bold24(context).copyWith(
            color: Utils.isDark(context)? Colors.black : Colors.white
              ),
            ),
          ),

          // "View All" Pill Button with circular arrow icon
          GestureDetector(
            onTap: category.onTap,
            child: Container(
              height: 44,
              padding: isRtlLocal ? const EdgeInsets.only(left: 4, right: 18) : const EdgeInsets.only(left: 18, right: 4),
              decoration: BoxDecoration(
                color:Utils.isDark(context) ? Colors.black.withAlpha(85) : Colors.grey.withAlpha(85),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "View All",
                    style: AppStyles.bold16(context).copyWith(
                        color: Utils.isDark(context)? Colors.white : Colors.black
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 36,
                    width: 36,
                    decoration:  BoxDecoration(
                      color: Utils.isDark(context) ? AppColors.black : AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      color: Utils.isDark(context) ? AppColors.white : AppColors.black,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}