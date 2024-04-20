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

  ListProvider() {
    messages = List<MessageItem>.generate(100,
        (index) => MessageItem(Key(index.toString()), 'Item ${index + 1}'));
  }

  Future<List<MessageItem>> fetchData() async {
    // Simulate a network call.
    if (!initialized) {
      initialized = true;
      debugPrint('fetchData ...');
      await Future.delayed(const Duration(seconds: 2));
    }
    return messages;
  }

  void addMessage() {
    ++lastMessageId;
    messages.insert(
        0, MessageItem(Key(lastMessageId.toString()), 'Item $lastMessageId'));
    notifyListeners();
  }
}

class TwoPagesWithMessagesWithProviderPage extends StatefulWidget {
  const TwoPagesWithMessagesWithProviderPage({super.key});

  @override
  State<TwoPagesWithMessagesWithProviderPage> createState() =>
      _TwoPagesWithMessagesWithProviderPageState();
}

class _TwoPagesWithMessagesWithProviderPageState
    extends State<TwoPagesWithMessagesWithProviderPage> {
  ListProvider listProvider = ListProvider();

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            child: const FutureListViewWithProvider(),
          ),
        ],
      ),
    );
  }
}

class FutureListViewWithProvider extends StatefulWidget {
  const FutureListViewWithProvider({
    super.key,
  });

  @override
  State<FutureListViewWithProvider> createState() =>
      _FutureListViewWithProviderState();
}

class _FutureListViewWithProviderState extends State<FutureListViewWithProvider>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ListProvider>(builder: (context, listProvider, child) {
      debugPrint('building the FutureListView');
      return FutureBuilder<List<MessageItem>>(
        future: listProvider.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   _scrollToEnd();
            // });
            return Column(children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    debugPrint('building item $index');
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.orangeAccent,
                        child: ListTile(
                          key: snapshot.data![index].key,
                          title: Text(snapshot.data![index].name),
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
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: const Text('Send'),
                  ),
                ],
              ),
            ]);
          }
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void _scrollToEnd() async {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
