import 'package:flutter/material.dart';

import '../../../utils/const/colors.dart';
import '../../../utils/const/styles.dart';

class HomeDrawerWidget extends StatelessWidget {
   HomeDrawerWidget({super.key,required this.title, required this.initValue, required this.items, required this.onChanged, required this.iconTitle});
  String title;
  String initValue;
  IconData iconTitle;
  List<DropdownMenuItem<String>> items;
  void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
           iconTitle,
            color: AppColors.white,
          ),
          title: Text(
            title,
            style: AppStyles.bold20(
              context,
            ).copyWith(color: AppColors.white),
          ),

          onTap: () {
            Navigator.pop(context);
          },
        ),
        DropdownButtonFormField<String>(
          initialValue: initValue,
          style: AppStyles.bold16(
            context,
          ).copyWith(color: AppColors.white),
          iconDisabledColor: AppColors.white,
          iconEnabledColor: AppColors.white,
          dropdownColor: AppColors.black,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.black,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(
                color: AppColors.white,

              ),
            ),
            enabled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(
                color: AppColors.white,

              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(
                color: AppColors.white,

              ),
            ),
          ),
          items: items,
        onChanged: onChanged,
        ),
      ],
    );
  }
}
