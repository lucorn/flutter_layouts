// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class AllGroups {
  List<ItemsGroup> groups = [];

  int get itemsCount {
    int count = 0;

    for (int i = 0; i < groups.length; i++) {
      count += groups[i].items.length;
    }

    return count;
  }

  int get allTtemsCount {
    return itemsCount + groups.length;
  }
}

class ItemsGroup {
  String name = '';
  List<Item> items = [];
  Color color;

  ItemsGroup({required this.name, required this.color});
}

class Item {
  String name;
  String subtitle;

  bool completed;

  Item({required this.name, required this.subtitle, required this.completed});
}

class ThirdPage extends StatelessWidget {
  final AllGroups allGroups = AllGroups();

  // initialize with content
  ThirdPage({super.key}) {
    ItemsGroup notCompleted =
        ItemsGroup(name: 'Not completed', color: Colors.greenAccent);

    allGroups.groups.add(notCompleted);

    // load the list of items
    notCompleted.items.add(Item(
        name: 'theDude', subtitle: 'updated moments ago', completed: false));
    // notCompleted.items.add(Item(
    //     name: 'moveNow', subtitle: 'updated 3 hours ago', completed: false));
    // notCompleted.items.add(Item(
    //     name: 'TheBest', subtitle: 'updated 2 days ago', completed: false));
    // notCompleted.items.add(Item(
    //     name: 'Once7', subtitle: 'updated 22 minutes ago', completed: false));
    // notCompleted.items.add(Item(
    //     name: 'moveNow', subtitle: 'updated 3 hours ago', completed: false));
    // notCompleted.items.add(Item(
    //     name: 'TheBest', subtitle: 'updated 2 days ago', completed: false));
    // notCompleted.items.add(Item(
    //     name: 'Once7', subtitle: 'updated 22 minutes ago', completed: false));

    ItemsGroup completed =
        ItemsGroup(name: 'Completed', color: Colors.orangeAccent);

    allGroups.groups.add(completed);

    completed.items.add(Item(
        name: 'MaybeToday', subtitle: 'updated 4 days ago', completed: true));
    // completed.items.add(Item(
    //     name: 'moveNow', subtitle: 'updated 12 hours ago', completed: true));
    // completed.items.add(Item(
    //     name: 'theDude', subtitle: 'updated 5 hours ago', completed: true));
    // completed.items.add(Item(
    //     name: 'Entry42', subtitle: 'updated 14 minutes ago', completed: true));
    // completed.items.add(Item(
    //     name: 'OlderThanYou', subtitle: 'updated 5 days ago', completed: true));
    // completed.items.add(Item(
    //     name: 'anotherTry', subtitle: 'updated 2 hours ago', completed: true));
    // completed.items.add(Item(
    //     name: 'hurryUp', subtitle: 'updated 5 minutes ago', completed: true));
    // completed.items.add(Item(
    //     name: 'theDude', subtitle: 'updated 5 hours ago', completed: true));
    // completed.items.add(Item(
    //     name: 'Entry42', subtitle: 'updated 14 minutes ago', completed: true));
    // completed.items.add(Item(
    //     name: 'OlderThanYou', subtitle: 'updated 5 days ago', completed: true));
    // completed.items.add(Item(
    //     name: 'anotherTry', subtitle: 'updated 2 hours ago', completed: true));
    // completed.items.add(Item(
    //     name: 'hurryUp', subtitle: 'updated 5 minutes ago', completed: true));
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
        itemCount: allGroups.allTtemsCount,
        itemBuilder: (BuildContext context, int index) {
          ItemsGroup group;
          Item item;

          // find the group and the item for this index
          int items = 0;
          int gr = 0;

          while (items < index) {
            group = allGroups.groups[gr];
            if (group.items.length + items < index) {
              items += group.items.length + 1;
              gr++;
            } else {
              break;
            }
          }
          if (items == index) {
            // render the header for group gr
            return Container(
              color: Colors.white54,
              margin: const EdgeInsets.all(6),
              child: Text(
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  '${allGroups.groups[gr].name} (${allGroups.groups[gr].items.length})'),
            );
          } else {
            // render item index - items - 1
            item = allGroups.groups[gr].items[index - items - 1];
            return Blade(allGroups: allGroups, gr: gr, item: item);
          }
        },
      ),
    );
  }
}

class Blade extends StatelessWidget {
  const Blade({
    super.key,
    required this.allGroups,
    required this.gr,
    required this.item,
  });

  final AllGroups allGroups;
  final int gr;
  final Item item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('tapped on item ${item.name}');
      }, // Handle your callback

      child: Container(
        decoration: BoxDecoration(
            color: allGroups.groups[gr].color,
            border: Border.all(
              color: allGroups.groups[gr].color,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 4,
                blurRadius: 7,
                offset: const Offset(3, 3), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(3))),
        margin: const EdgeInsets.fromLTRB(6, 2, 10, 10),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name),
              Text(item.subtitle),
              Badge.count(
                  count: 3,
                  child: const Icon(
                    Icons.comment_outlined,
                    color: Colors.black45,
                    size: 35,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
