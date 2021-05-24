import 'package:fake_whatsapp_chat/pages/conversation/whatsapp_conversation_view.dart';
import 'package:fake_whatsapp_chat/pages/conversation/whatsapp_conversation_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_viewmodel.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewmodel>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () {},
        ),
        body: ListView.separated(
            itemBuilder: (_, i) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                            create: (_) => WhatsappConversationViewmodel(),
                            child: WhatsappConversationView(
                                chat: vm.chatList.elementAt(i)))));
                  },
                  child: ListTile(
                    leading: CircleAvatar(radius: 20),
                    title: Text(vm.chatList.elementAt(i).recepientName),
                    subtitle: Text(vm.chatList.elementAt(i).lastMessage),
                  ),
                ),
            separatorBuilder: (_, i) => Divider(
                  height: 0,
                  indent: 72,
                ),
            itemCount: vm.chatList.length));
  }
}
