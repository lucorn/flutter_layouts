import 'package:flutter/material.dart';

class FourthPage extends StatefulWidget {
  const FourthPage({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The fourth page'),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      body: const FutureListView(),
    );
  }
}

class FutureListView extends StatefulWidget {
  const FutureListView({
    super.key,
  });

  @override
  State<FutureListView> createState() => _FutureListViewState();
}

class _FutureListViewState extends State<FutureListView> {
  final ScrollController _scrollController = ScrollController();

  Future<List<String>> fetchData() async {
    // Simulate a network call.
    await Future.delayed(const Duration(milliseconds: 600));
    return List<String>.generate(100, (index) => 'Item ${index + 1}');
  }

  @override
  Widget build(BuildContext context) {
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
          return ListView.builder(
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
          );
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
}