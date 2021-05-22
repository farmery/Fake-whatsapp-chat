class Chat {
  String chatId;
  String recepientName;
  String recepientId;
  String lastMessage;
  List messages;
  String photoUrl;

  Chat({
    this.chatId = '',
    this.recepientName = '',
    this.recepientId = '',
    this.lastMessage = '',
    this.messages = const [],
    this.photoUrl = '',
  });
}
