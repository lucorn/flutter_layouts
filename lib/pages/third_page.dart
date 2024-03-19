import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ItemsGroup {
  List<Item> items = [];
}

class Item {
  String name;
  String subtitle;

  bool completed;

  Item({required this.name, required this.subtitle, required this.completed});
}

class ThirdPage extends StatelessWidget {
  List<Item> items = [];

  List<ItemsGroup> groups = [];

  ThirdPage({super.key}) {
    // load the list of items
    items.add(Item(
        name: 'theDude', subtitle: 'updated moments ago', completed: false));
    items.add(Item(
        name: 'moveNow', subtitle: 'updated 3 hours ago', completed: false));
    items.add(Item(
        name: 'TheBest', subtitle: 'updated 2 days ago', completed: false));
    items.add(Item(
        name: 'Once7', subtitle: 'updated 22 minutes ago', completed: false));
    items.add(Item(
        name: 'moveNow', subtitle: 'updated 3 hours ago', completed: false));
    items.add(Item(
        name: 'TheBest', subtitle: 'updated 2 days ago', completed: false));
    items.add(Item(
        name: 'Once7', subtitle: 'updated 22 minutes ago', completed: false));
    items.add(Item(
        name: 'MaybeToday', subtitle: 'updated 4 days ago', completed: true));
    items.add(Item(
        name: 'moveNow', subtitle: 'updated 12 hours ago', completed: true));
    items.add(Item(
        name: 'theDude', subtitle: 'updated 5 hours ago', completed: true));
    items.add(Item(
        name: 'Entry42', subtitle: 'updated 14 minutes ago', completed: true));
    items.add(Item(
        name: 'OlderThanYou', subtitle: 'updated 5 days ago', completed: true));
    items.add(Item(
        name: 'anotherTry', subtitle: 'updated 2 hours ago', completed: true));
    items.add(Item(
        name: 'hurryUp', subtitle: 'updated 5 minutes ago', completed: true));
    items.add(Item(
        name: 'theDude', subtitle: 'updated 5 hours ago', completed: true));
    items.add(Item(
        name: 'Entry42', subtitle: 'updated 14 minutes ago', completed: true));
    items.add(Item(
        name: 'OlderThanYou', subtitle: 'updated 5 days ago', completed: true));
    items.add(Item(
        name: 'anotherTry', subtitle: 'updated 2 hours ago', completed: true));
    items.add(Item(
        name: 'hurryUp', subtitle: 'updated 5 minutes ago', completed: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third page'),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          Item item = items[index];

          if (index == 0) {
            return Container(
              color: Colors.white54,
              margin: const EdgeInsets.all(8),
              child: const Text('My Turn'),
            );
          }

          return Container(
            color: Colors.greenAccent,
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name),
                Text(item.subtitle),
              ],
            ),
          );
        },
      ),
    );
  }
}
