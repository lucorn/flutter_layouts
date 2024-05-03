import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageItem {
  final Key key;
  final String name;

  MessageItem(this.key, this.name);
}

class ListProvider extends ChangeNotifier {
  late List<MessageItem> messages;
  int lastMessageId = 100;

  bool initialized = false;

  Future<void> fetchData() async {
    // Simulate a network call.
    if (!initialized) {
      initialized = true;
      debugPrint('fetchData: waiting for 2 seconds ...');
      await Future.delayed(const Duration(seconds: 2));

      messages = List<MessageItem>.generate(100,
          (index) => MessageItem(Key(index.toString()), 'Item ${index + 1}'));

      notifyListeners();
    }
  }

  void addMessage() {
    ++lastMessageId;
    messages.insert(
        0, MessageItem(Key(lastMessageId.toString()), 'Item $lastMessageId'));
    notifyListeners();
  }
}

class TwoPagesWithMessagesWithProviderPage extends StatelessWidget {
  final ListProvider listProvider = ListProvider();

  TwoPagesWithMessagesWithProviderPage({super.key});

  void addMessage() {
    listProvider.addMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The fourth page'),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      body: PageView(
        children: [
          Container(
            color: Colors.greenAccent,
            child: Column(
              children: [
                const Text('Add item to the list of messages'),
                ElevatedButton(
                  onPressed: () {
                    addMessage();
                  },
                  child: const Text('Add item'),
                ),
              ],
            ),
          ),
          ChangeNotifierProvider<ListProvider>.value(
            value: listProvider,
            child: const ListViewWithProvider(),
          ),
        ],
      ),
    );
  }
}

class ListViewWithProvider extends StatelessWidget {
  const ListViewWithProvider({
    super.key,
  });

  //final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(builder: (context, listProvider, child) {
      debugPrint('building the listview');
      if (listProvider.initialized == false) {
        listProvider.fetchData();
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Column(children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            //controller: _scrollController,
            itemCount: listProvider.messages.length,
            itemBuilder: (context, index) {
              final item = listProvider.messages[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.orangeAccent,
                  child: ListTile(
                    key: item.key,
                    title: Text(item.name),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          children: [
            IconButton(
                icon: const Icon(Icons.grid_view),
                iconSize: 36,
                color: Colors.black,
                tooltip: 'chat',
                onPressed: () {
                  debugPrint('go to chat');
                }),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'type your text here',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint('Send text clicked!');
                listProvider.addMessage();
                // _scrollController.animateTo(
                //     _scrollController.position.maxScrollExtent,
                //     duration: const Duration(milliseconds: 300),
                //     curve: Curves.easeIn);
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ]);
    });
  }
}
