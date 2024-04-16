// ignore_for_file: avoid_print

import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
//import 'package:badges/badges.dart' as badges;
import 'package:flutter_layouts/pages/fourth_page.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late ChatController chatController;
  late ChatUser currentUser;
  @override
  void initState() {
    super.initState();

    currentUser = ChatUser(id: '1', name: 'TheDude');

    List<Message> messageList = [
      Message(
        id: '1',
        message: "Hi there friend!",
        createdAt: DateTime.now(),
        sendBy: '1',
      ),
      Message(
        id: '2',
        message: "Hello to you too...",
        createdAt: DateTime.now(),
        sendBy: '2',
      ),
      Message(
        id: '3',
        message: "Doobeedeedoo",
        createdAt: DateTime.now(),
        sendBy: '3',
      ),
      Message(
        id: '4',
        message: "Can we play some game?",
        createdAt: DateTime.now(),
        sendBy: '1',
      ),
      Message(
        id: '5',
        message: "Can I join you too?",
        createdAt: DateTime.now(),
        sendBy: '4',
      ),
      Message(
        id: '6',
        message: "Can I join you too?",
        createdAt: DateTime.now(),
        sendBy: '2',
      ),
      Message(
        id: '7',
        message: "Can I join you too?",
        createdAt: DateTime.now(),
        sendBy: '3',
      ),
      Message(
        id: '8',
        message: "I wonder what kind of perf issue does this have",
        createdAt: DateTime.now(),
        sendBy: '1',
      ),
      Message(
        id: '9',
        message: "How does this make any sense.",
        createdAt: DateTime.now(),
        sendBy: '2',
      ),
      Message(
        id: '10',
        message:
            "Good to hear that this is not completely broken. Glad I can get to see it mentioned somewhere recently.. 🤣",
        createdAt: DateTime.now(),
        sendBy: '1',
      ),
      Message(
        id: '11',
        message: "Are you still with me?",
        createdAt: DateTime.now(),
        sendBy: '2',
      ),
      Message(
        id: '12',
        message: "So far away we go on a trip to visit some distant land",
        createdAt: DateTime.now(),
        sendBy: '2',
      ),
      Message(
        id: '13',
        message: "Sometime it would work",
        createdAt: DateTime.now(),
        sendBy: '1',
      ),
      Message(
        id: '14',
        message: "How may you help me?",
        createdAt: DateTime.now(),
        sendBy: '2',
      ),
    ];
    chatController = ChatController(
      initialMessageList: messageList,
      scrollController: ScrollController(),
      chatUsers: [
        ChatUser(id: '2', name: 'Simform'),
        ChatUser(id: '3', name: 'Enpassant'),
        ChatUser(id: '4', name: 'Jimmy'),
      ],
    );
  }

  void onSendTap(
      String message, ReplyMessage replyMessage, MessageType messageType) {
    final message = Message(
      id: '3',
      message: "How are you",
      createdAt: DateTime.now(),
      sendBy: currentUser.id,
      replyMessage: replyMessage,
      messageType: messageType,
    );
    chatController.addMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    print('Building the second page');
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        foregroundColor: Colors.white,
        title: const Text('Second page'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {},
          ), //IconButton
        ],
        shadowColor: Colors.grey,
      ),
      body: PageView(
        children: [
          const GameView(),
          const FutureListView(),
          ChatView(
            currentUser: currentUser,
            chatController: chatController,
            onSendTap: onSendTap,
            chatBackgroundConfig: ChatBackgroundConfiguration(
              backgroundColor: Colors.yellowAccent,
            ),
            reactionPopupConfig: ReactionPopupConfiguration(
              backgroundColor: Colors.white,
              userReactionCallback: (message, emoji) {
                // Your code goes here
                print('reacted with $emoji to ${message.message}');
              },
              padding: EdgeInsets.all(12),
              shadow: BoxShadow(
                color: Colors.black54,
                blurRadius: 20,
              ),
            ),
            chatViewState: ChatViewState
                .hasMessages, // Add this state once data is available.
          ),
        ],
      ),
    );
  }
}

class SomeChatView extends StatefulWidget {
  const SomeChatView({super.key});

  @override
  State<SomeChatView> createState() => _SomeChatViewState();
}

class _SomeChatViewState extends State<SomeChatView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('building the CHAT view');
    return Container(color: Colors.greenAccent);
  }

  @override
  bool get wantKeepAlive => true;
}

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('building the GAME view');
    return Container(color: Colors.amber);
  }

  @override
  bool get wantKeepAlive => true;
}
