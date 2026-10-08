import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/chat_app/chat_screen/widgets/chat_bubble.dart';
import 'package:news_app/screens/chat_app/cubit/cubit.dart';
import 'package:news_app/screens/chat_app/cubit/state.dart';
import 'package:news_app/utils/const/colors.dart';
import 'package:news_app/utils/const/styles.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
       var cubit = ChatCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Chat Screen', style: AppStyles.bold20(context),),
          ),
          body: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                Expanded(child:

                StreamBuilder(stream: cubit.getMessages(), builder: (context, snapshot) {

                  if(snapshot.connectionState==ConnectionState.waiting) {
                    return  Center(child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),);
                  }
                  if(!snapshot.hasData || snapshot.data!.isEmpty){
                    return Center(child: Text('No messages', style: AppStyles.bold20(context),),);
                  }
                  if(snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}', style: AppStyles.bold20(context),),);
                  }
                  final messages = snapshot.data!;
                  return ListView.builder(
                    itemCount: messages.length,
                   itemBuilder: (context, index) {
                      final msg = messages[index];
                      return ChatBubble(meg:msg);


                   },);




                },)
                ),



                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: AppColors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cubit.messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),validator: (v){
                            if(v!.isEmpty) {
                              return 'Please enter a message';
                            }
                            return null;
                        },
                        ),

                      ),
                      const SizedBox(width: 8.0),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if(cubit.formKey.currentState!.validate()) {
                            cubit.sendMessage(context);
                            cubit.messageController.clear();
                          }
                        },
                      ),
                    ],
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
