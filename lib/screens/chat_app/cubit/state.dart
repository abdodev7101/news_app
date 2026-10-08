abstract class ChatState{}
 class ChatInitialState extends ChatState{}
class ChatLoadingState extends ChatState {}

class ChatSuccessState extends ChatState {}

class ChatErrorState extends ChatState {
 final String error;
 ChatErrorState(this.error);
}class GetUserLoadingState extends ChatState {}

class GetUserSuccessState extends ChatState {}

class GetUserErrorState extends ChatState {
 final String error;
 GetUserErrorState(this.error);
}
class ChatChangePasswordVisibilityState extends ChatState {}
class SignOutState extends ChatState {}
class SendMessageLoadingState extends ChatState {}
class SendMessageSuccessState extends ChatState {}
class SendMessageErrorState extends ChatState {
  final String error;
  SendMessageErrorState(this.error);
}