import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/screens/chat_app/cubit/cubit.dart';
import 'package:news_app/utils/utils.dart';

import '../../../../utils/const/colors.dart';
import '../../../../utils/const/styles.dart';
import '../../model/chat_model.dart';

class ChatBubble extends StatelessWidget {
  final ChatModel meg;
  const ChatBubble({super.key, required this.meg});

  @override
  Widget build(BuildContext context) {
    final isSender = meg.senderId == FirebaseAuth.instance.currentUser!.uid;

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,

        ),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isSender ? AppColors.grey   : AppColors.green,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              !isSender ? Text(meg.name??'em',style: AppStyles.bold16(context).copyWith(color: AppColors.black),) : SizedBox.shrink(),
              SizedBox(height: 5,),
            meg.ifImage ?
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(meg.message,
              ),
            )
                : Text(meg.message, style: AppStyles.boldw14(context).copyWith(color: AppColors.black),),

              SizedBox(height: 5,),
              Text(formatTimeStamp(meg.timeStamp), style: AppStyles.Reglw14(context).copyWith(color: AppColors.black),),
            ],
          )
      ),
    );
  }
  String formatTimeStamp(String timeStamp) {
    DateTime parsedDate;

    // Check if the string is purely a number (epoch milliseconds)
    if (int.tryParse(timeStamp) != null) {
      int millis = int.parse(timeStamp);
      parsedDate = DateTime.fromMillisecondsSinceEpoch(millis);
    } else {
      // Otherwise, treat it as a standard date-time string
      parsedDate = DateTime.parse(timeStamp);
    }

    // Format to hh:mm am/pm
    return DateFormat('hh:mm a').format(parsedDate);
  }
}
