import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

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
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(text: 'Game'),
              Tab(text: 'Chat'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GameView(),
            ChatView(),
          ],
        ),
      ),
    );
  }
}

class ChatView extends StatelessWidget {
  ChatView({super.key}) {
    print('Initializing the CHAT view');
  }

  @override
  Widget build(BuildContext context) {
    print('building the CHAT view');
    return Container(color: Colors.greenAccent);
  }
}

class GameView extends StatelessWidget {
  GameView({super.key}) {
    print('Initializing the GAME view');
  }

  @override
  Widget build(BuildContext context) {
    print('building the GAME view');
    return Container(color: Colors.amber);
  }
}
