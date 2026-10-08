import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/chat_app/cubit/state.dart';
import 'package:news_app/screens/chat_app/model/chat_model.dart';
import 'package:news_app/screens/login/cubit/cubit.dart';
import 'package:news_app/utils/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/network/end_points.dart';
import '../../../utils/utils.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState()) {}

  static ChatCubit get(context) => BlocProvider.of<ChatCubit>(context);

  final formKey = GlobalKey<FormState>();
  var messageController = TextEditingController();

  var db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<ChatModel>> getMessages() {
    return db
        .collection(EndPoints.chatCollection)
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ChatModel.fromJson(doc.data());
          }).toList();
        });
  }

  Future<void> sendMessage(context) async {
    emit(SendMessageLoadingState());
    if (messageController.text.isEmpty) return;

    if (auth.currentUser == null) {
      emit(SendMessageErrorState('User is not logged in'));
      return;
    }

    try {
      ChatModel chatModel = ChatModel(
        ifImage: false,
        message: messageController.text,
        senderId: auth.currentUser!.uid,

        timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
      );
      await db.collection(EndPoints.chatCollection).add(chatModel.toJson());

      emit(SendMessageSuccessState());
    } catch (e) {
      print(e.toString());
      emit(SendMessageErrorState(e.toString()));
    }
  }
}
