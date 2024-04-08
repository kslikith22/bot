class MessageModel {
  final String message;
  final String reply;

  MessageModel({
    required this.message,
    required this.reply,
  });

  factory MessageModel.fromJson(Map<String, dynamic> jsonData) {
    return MessageModel(
      message: jsonData['message'],
      reply: jsonData['reply'],
    );
  }

  @override
  String toString() {
    return 'MessageModel(message: $message, reply: $reply)';
  }
}
