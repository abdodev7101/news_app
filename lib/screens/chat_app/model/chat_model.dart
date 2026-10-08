class ChatModel {
  String senderId;
  String message;
  String timeStamp;
  bool ifImage;

  ChatModel({
    required this.senderId,
    required this.message,
    required this.timeStamp,
    required this.ifImage,
  });


  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      senderId: json['senderId'],
      message: json['message'],
      timeStamp: json['timeStamp'],
      ifImage: json['ifImage'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'message': message,
      'timeStamp': timeStamp,
      'ifImage': ifImage,
    };
}
}
