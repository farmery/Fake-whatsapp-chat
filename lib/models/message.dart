import 'package:expensive_prank/models/user.dart';

class Message {
  String id;
  String text;
  String imageUrl;
  String sentAt;
  User sentBy;
  Message({
    this.id = '',
    this.text = '',
    this.imageUrl = '',
    this.sentAt = '',
    this.sentBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'imageUrl': imageUrl,
      'sentAt': sentAt,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Message(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      sentAt: map['sentAt'] ?? '',
    );
  }
}
