import 'package:fake_whatsapp_chat/pages/home/home_viewmodel.dart';
import 'package:fake_whatsapp_chat/services/login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LoginNotifier().getUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewmodel()),
        ChangeNotifierProvider(create: (_) => LoginNotifier())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            backgroundColor: Color(0xff131C21),
            scaffoldBackgroundColor: Color(0xff131C21),
            primaryColor: Colors.blueGrey[900],
            highlightColor: Colors.white.withOpacity(0.3),
            dividerColor: Colors.white.withOpacity(0.4),
            splashColor: Colors.transparent,
            brightness: Brightness.dark,
            accentColor: Color(0xff00AF9C),
            primarySwatch: Colors.blue,
          ),
          home: Wrapper()),
    );
  }
}
