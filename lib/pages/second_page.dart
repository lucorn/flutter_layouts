import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_layouts/pages/fourth_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building the second page');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          children: const [
            GameView(),
            FutureListView(),
          ],
        ),
      ),
    );
  }
}

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    print('building the CHAT view');
    return Container(color: Colors.greenAccent);
  }
}

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    print('building the GAME view');
    return Container(color: Colors.amber);
  }
}
