import 'package:expensive_prank/models/chat.dart';
import 'package:flutter/widgets.dart';

class HomeViewmodel with ChangeNotifier {
  List<Chat> chatList = [
    Chat(
        recepientName: 'Nicki minaj',
        lastMessage: 'hey boo',
        chatId: 'hey boo',
        recepientId: 'nicki')
  ];
}
