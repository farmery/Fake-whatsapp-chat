import 'package:fake_whatsapp_chat/models/user.dart';
import 'package:fake_whatsapp_chat/pages/home/home_view.dart';
import 'package:fake_whatsapp_chat/services/login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userStream = Provider.of<LoginNotifier>(context).getUser();
    return FutureBuilder<User>(
        future: userStream,
        builder: (_, snapshot) {
          print(snapshot.data);
          return snapshot.data.userId == null ? Login() : HomeView();
        });
  }
}
