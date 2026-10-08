class ChatModel {
  String senderId;
  String message;
  String timeStamp;
  String? name;
  bool ifImage;

  ChatModel({
    required this.senderId,
    required this.message,
    required this.timeStamp,
    this.name,
    required this.ifImage,
  });


  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      senderId: json['senderId'],
      message: json['message'],
      name: json['name'],
      timeStamp: json['timeStamp'],
      ifImage: json['ifImage'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'message': message,
      'timeStamp': timeStamp,
      'name': name,
      'ifImage': ifImage,
    };
}
}
