import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title of the page'),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              'Open sicilian',
              style: TextStyle(fontSize: 16),
            ),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8),
              itemBuilder: (context, index) {
                var row = index ~/ 8;
                var column = index % 8;

                return Container(
                  color:
                      (row + column) % 2 == 0 ? Colors.white : Colors.black38,
                );
              },
              itemCount: 64,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
          AspectRatio(
            aspectRatio: 16,
            child: Container(
              color: Colors.greenAccent,
            ),
          ),
          AspectRatio(
            aspectRatio: 4,
            child: Container(
              color: Colors.orangeAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('What If'),
                ),
                const Text('4..b4'),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: const Icon(Icons.keyboard_double_arrow_left),
                    iconSize: 36,
                    tooltip: 'start',
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.keyboard_arrow_left),
                    iconSize: 36,
                    tooltip: 'previous',
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.keyboard_arrow_right),
                    iconSize: 36,
                    tooltip: 'next',
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.keyboard_double_arrow_right),
                    iconSize: 36,
                    tooltip: 'end',
                    onPressed: () {}),
                badges.Badge(
                  badgeContent: const Text('2'),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.amber,
                    elevation: 0,
                  ),
                  position: badges.BadgePosition.topEnd(top: -3, end: 0),
                  child: IconButton(
                      icon: const Icon(Icons.people_outlined),
                      iconSize: 36,
                      tooltip: 'watchers',
                      onPressed: () {}),
                ),
                Badge.count(
                    count: 3,
                    textColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 14),
                    backgroundColor: Colors.orangeAccent,
                    child: IconButton(
                        icon: const Icon(Icons.mark_chat_unread_outlined),
                        iconSize: 36,
                        color: Colors.red,
                        tooltip: 'chat',
                        onPressed: () {})),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
