import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({super.key});

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Launcher Page'),
        elevation: 0,
      ),
      body: Container(
        color: Colors.amber,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              debugPrint('go to another page');
              context.push(Uri(path: '/appbarStudy/42').toString());
              // Navigator.pushNamed(context, '/appbarStudy',
              //     arguments: {'id': 42});
            },
            child: const Text('go to another page'),
          ),
        ),
      ),
    );
  }
}
