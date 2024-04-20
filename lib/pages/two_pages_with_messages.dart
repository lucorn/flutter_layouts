import 'package:flutter/material.dart';

class TwoPagesWithMessagesPage extends StatefulWidget {
  const TwoPagesWithMessagesPage({super.key});

  @override
  State<TwoPagesWithMessagesPage> createState() =>
      _TwoPagesWithMessagesPageState();
}

class _TwoPagesWithMessagesPageState extends State<TwoPagesWithMessagesPage> {
  late List<String> messages;
  int lastMessageId = 100;

  @override
  initState() {
    super.initState();
    messages = List<String>.generate(100, (index) => 'Item ${index + 1}');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addMessage() {
    setState(() {
      messages.add('Item ${++lastMessageId}');
    });
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
          FutureListView(messages: messages),
        ],
      ),
    );
  }
}

class FutureListView extends StatefulWidget {
  final List<String> messages;
  const FutureListView({
    super.key,
    required this.messages,
  });

  @override
  State<FutureListView> createState() => _FutureListViewState();
}

class _FutureListViewState extends State<FutureListView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  Future<List<String>> fetchData() async {
    // Simulate a network call.
    await Future.delayed(const Duration(milliseconds: 600));
    return widget.messages;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint('building the FutureListView');
    return FutureBuilder<List<String>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToEnd();
          });
          return Column(children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.orangeAccent,
                      child: ListTile(
                        title: Text(snapshot.data![index]),
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
                      print('go to chat');
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
                    print('Send text clicked!');
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
