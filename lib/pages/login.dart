import 'package:fake_whatsapp_chat/models/user.dart';
import 'package:fake_whatsapp_chat/services/login_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameField;

  @override
  void initState() {
    super.initState();
    nameField = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    return Scaffold(
      floatingActionButton: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Next'),
          onPressed: () {
            //create user object
            loginNotifier.createUser(
                User(userName: nameField.text, userId: 'Uuid().v4()'));
          }),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Set your display picture',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 12),
            CircleAvatar(
              radius: 50,
            ),
            SizedBox(height: 32),
            TextField(
              controller: nameField,
              decoration: InputDecoration(hintText: 'Enter your display name'),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
