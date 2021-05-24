import 'package:fake_whatsapp_chat/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier with ChangeNotifier {
  Future<User> getUser() async {
    return await SharedPreferences.getInstance().then((prefs) {
      try {
        return User(
            userId: prefs.getString('userId'),
            userName: prefs.getString('userName'));
      } catch (e) {
        return null;
      }
    });
  }

  void createUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', user.userName);
    prefs.setString('userId', user.userId);
    notifyListeners();
  }
}
