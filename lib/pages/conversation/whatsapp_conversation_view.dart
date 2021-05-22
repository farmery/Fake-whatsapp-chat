import 'package:bubble/bubble.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:expensive_prank/models/chat.dart';
import 'package:expensive_prank/models/message.dart';
import 'package:expensive_prank/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:expensive_prank/services/login_notifier.dart';
import 'whatsapp_conversation_viewmodel.dart';

class WhatsappConversationView extends StatefulWidget {
  @override
  _WhatsappConversationViewState createState() =>
      _WhatsappConversationViewState();

  final Chat chat;
  WhatsappConversationView({this.chat});
}

class _WhatsappConversationViewState extends State<WhatsappConversationView> {
  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textController.addListener(() {});
    final viewModel =
        Provider.of<WhatsappConversationViewmodel>(context, listen: false);
    Provider.of<LoginNotifier>(context, listen: false).getUser().then((user) {
      viewModel.user = user;
      viewModel.activeUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final chat = widget.chat;
    final bubbleColor = Color(0xff232D36);
    final outgoingColor = Color(0xff056162);
    final accentColor = Color(0xff00AF9C);
    final viewModel = Provider.of<WhatsappConversationViewmodel>(context);

    return FutureBuilder<User>(
        future: Provider.of<LoginNotifier>(context).getUser(),
        builder: (context, snapshot) {
          User user = snapshot.data;
          return snapshot.connectionState == ConnectionState.done
              ? Scaffold(
                  appBar: buildAppbar(chat),
                  floatingActionButton: Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: viewModel.fabVisibility,
                      child: FloatingActionButton(
                        backgroundColor:
                            viewModel.activeUser.userId == viewModel.user.userId
                                ? outgoingColor
                                : bubbleColor,
                        child: Text(
                          viewModel.activeUser.userName.substring(0, 1),
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          viewModel.switchUser();
                        },
                        mini: true,
                      ),
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  body: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/images/whatsapp_wallpaper.jpg'))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: DashChat(
                            textController: textController,
                            showUserAvatar: false,
                            avatarBuilder: (_) => SizedBox(),
                            messageContainerPadding: EdgeInsets.zero,
                            inputContainerStyle: BoxDecoration(),
                            inputCursorColor: outgoingColor,
                            inputTextStyle: TextStyle(fontSize: 18),
                            inputDecoration: buildInputDecoration(bubbleColor),
                            alwaysShowSend: true,
                            onTextChange: (text) {
                              if (text != '' || text != null) {
                                viewModel.switchToSend();
                              }
                              if (text == '') {
                                viewModel.switchToMic();
                              }
                            },
                            sendButtonBuilder: (_) => CircleAvatar(
                                radius: 24,
                                backgroundColor: accentColor,
                                child: viewModel.isTyping
                                    ? Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: InkWell(
                                          onTap: () {
                                            if (textController.text != '') {
                                              viewModel.sendMessage(Message(
                                                  text: textController.text,
                                                  id: '739',
                                                  sentBy:
                                                      viewModel.activeUser));
                                              textController.clear();
                                            }
                                          },
                                          child: Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Icon(Icons.mic, color: Colors.white)),
                            dateFormat: DateFormat('dd:MM:yyyy'),
                            dateBuilder: (time) => Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: bubbleColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(time,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white
                                                .withOpacity(0.65))),
                                  ),
                                ),
                            messageBuilder: (msg) => buildBubble(
                                msg, user, outgoingColor, bubbleColor),
                            messages: viewModel.messages
                                .map((msg) => ChatMessage(
                                    text: msg.text,
                                    id: msg.id,
                                    user: ChatUser(
                                      name: msg.sentBy.userName,
                                      uid: msg.sentBy.userId,
                                    )))
                                .toList(),
                            user: ChatUser(
                              uid: user.userId,
                              name: user.userName,
                            ),
                            onSend: (msg) {}),
                      ),
                    ],
                  ),
                )
              : Container(color: bubbleColor);
        });
  }

  Widget buildBubble(
      ChatMessage msg, User user, Color outgoingColor, Color bubbleColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: msg.user.uid == user.userId
            ? const EdgeInsets.only(left: 35)
            : const EdgeInsets.only(right: 35),
        child: Bubble(
          alignment: msg.user.uid == user.userId
              ? Alignment.centerRight
              : Alignment.centerLeft,
          nip: msg.user.uid == user.userId
              ? BubbleNip.rightTop
              : BubbleNip.leftTop,
          color: msg.user.uid == user.userId ? outgoingColor : bubbleColor,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    //text
                    TextSpan(
                        text: msg.user.uid == user.userId
                            ? msg.text + '   '
                            : msg.text + ''),
                    //time inline
                    TextSpan(
                        text: DateFormat('HH:mm').format(msg.createdAt) +
                            '         ',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.transparent,
                        ))
                  ]),
                ),
              ),

              //time multilined
              msg.user.uid == user.userId
                  ? Positioned(
                      bottom: 0,
                      right: 4,
                      child: Row(
                        children: [
                          Text(
                            DateFormat('HH:mm').format(msg.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.65),
                            ),
                          ),
                          SizedBox(width: 4),
                          Image.asset(
                            'assets/icons/double_check.png',
                            height: 10,
                          )
                        ],
                      ),
                    )
                  : Positioned(
                      bottom: 0,
                      right: 4,
                      child: Row(
                        children: [
                          Text(
                            DateFormat('HH:mm').format(msg.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.65),
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(Color bubbleColor) {
    return InputDecoration(
        hintText: 'Type a message',
        contentPadding: EdgeInsets.fromLTRB(8, 12, 12, 12),
        suffixIconConstraints: BoxConstraints.tight(Size(82, 20)),
        prefixIcon: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.emoji_emotions,
              color: Colors.white.withOpacity(0.6),
              size: 23,
            )),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Transform(
                origin: Offset(11, 11.5),
                transform: Matrix4.rotationZ(-0.8),
                child: InkWell(
                    onTap: () {},
                    child: Icon(
                      MaterialIcons.attach_file,
                      color: Colors.white.withOpacity(0.6),
                      size: 23,
                    )),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white.withOpacity(0.6),
                    size: 23,
                  )),
            ],
          ),
        ),
        filled: true,
        fillColor: bubbleColor,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(35)));
  }

  PreferredSize buildAppbar(Chat chat) {
    final viewModel =
        Provider.of<WhatsappConversationViewmodel>(context, listen: false);
    return PreferredSize(
        child: SafeArea(
          child: Container(
            color: Color(0xff273238),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, top: 4, bottom: 4, right: 8),
                      child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              CircleAvatar()
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(chat.recepientName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4),
                          Text('online',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.60))),
                        ]),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.call),
                    SizedBox(width: 12),
                    Icon(Ionicons.ios_videocam),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: PopupMenuButton(
                        enabled: true,
                        itemBuilder: (_) => [
                          PopupMenuItem(
                              height: 28,
                              child: InkWell(
                                  onTap: () {
                                    viewModel.toggleFabVisibility();
                                  },
                                  child: Text('Hide user switch')))
                        ],
                        padding: EdgeInsets.zero,
                        child: Icon(Icons.more_vert, color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(58));
  }
}
