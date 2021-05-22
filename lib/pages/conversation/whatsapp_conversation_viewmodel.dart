import 'package:expensive_prank/models/message.dart';
import 'package:expensive_prank/models/user.dart';
import 'package:flutter/cupertino.dart';

class WhatsappConversationViewmodel with ChangeNotifier {
  bool isTyping = false;
  bool isLoaded = false;
  bool fabVisibility = true;
  User activeUser;
  User user;
  User fakeUser = User(userName: 'Nicki minaj', userId: '2');

  List<Message> messages = [];

  void switchUser() {
    if (activeUser.userId == user.userId) {
      activeUser = fakeUser;
      notifyListeners();
    } else {
      activeUser = user;
      notifyListeners();
    }
  }

  void switchToSend() {
    isTyping = true;
    notifyListeners();
  }

  void switchToMic() {
    isTyping = false;
    notifyListeners();
  }

  void sendMessage(Message msg) {
    messages.add(msg);
    notifyListeners();
  }

  void onScreenLoad() {
    isLoaded = true;
    notifyListeners();
  }

  void toggleFabVisibility() {
    fabVisibility = !fabVisibility;
    notifyListeners();
  }
}
